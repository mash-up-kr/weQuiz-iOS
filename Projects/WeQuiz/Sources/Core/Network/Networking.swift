//
//  Networking.swift
//  CoreKit
//
//  Created by AhnSangHoon on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

import Alamofire

public protocol NetworkingProtocol {
    func request<T: Decodable>(
        _ model: BaseDataResponseModel<T>.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Networking.NetworkingError>) -> ())
    )
    
    func request<T: Decodable>(
        _ model: BaseDataResponseModel<T>.Type,
        _ requestable: NetworkRequestable
    ) async -> Result<T?, Networking.NetworkingError>
    
    func requestMultipartFormData<T:Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Networking.NetworkingError>) -> ())
    )
}

public final class Networking: NetworkingProtocol {
    
    public enum NetworkingError: Error {
        case emptyResponse
        case decodingError
        case wrongRequest
        case wrongEndpoint
        case response(AFError)
        case errorMessage(String)
        
        public var message: String {
            switch self {
            case .errorMessage(let message):
                return message
            default:
                return "네트워크 에러입니다."
            }
        }
    }
    
    public init() { }
    
    public func request<T: Decodable>(
        _ model: BaseDataResponseModel<T>.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Networking.NetworkingError>) -> ())
    ) {
        do {
            let endpoint = try requestable.endpoint()
            let parameters = requestable.parameters?.requestable ?? [:]
            AF.request(
                endpoint,
                method: requestable.method.httpMethod,
                parameters: parameters,
                encoding: requestable.encoding.parmeterEncoding,
                headers: requestable.headers?.httpHeaders ?? .default
            )
            .responseDecodable(
                of: model.self,
                completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        if value.code != "SUCCESS" {
                            completion(.failure(NetworkingError.errorMessage(value.message ?? "")))
                        } else {
                            completion(.success(value.data))
                        }
                    case .failure(let error):
                        completion(.failure(.response(error)))
                    }
            })
        } catch {
            requestErrorHandling(error)
            completion(.failure(NetworkingError.wrongRequest))
        }
    }
    
    public func request<T: Decodable>(
        _ model: BaseDataResponseModel<T>.Type,
        _ requestable: NetworkRequestable
    ) async -> Result<T?, Networking.NetworkingError> {
        await withCheckedContinuation{ continuation in
            request(model, requestable) {
                continuation.resume(returning: $0)
            }
        }
    }
    
    public func requestMultipartFormData<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Networking.NetworkingError>) -> ())
    ) where T : Decodable {
        do {
            let endPoint = try requestable.endpoint()
            let parameters = requestable.parameters?.multiPartRequestable ?? [:]
            AF.upload(
                multipartFormData: { multipartFormData in
                    for (key, value) in parameters {
                        if key == "image" {
                            multipartFormData.append(
                                value,
                                withName: "image",
                                fileName: "file.png",
                                mimeType: "image/png"
                            )
                        } else {
                            multipartFormData.append(
                                value,
                                withName: key,
                                fileName: key,
                                mimeType: "application/json"
                            )
                        }
                    }
                },
                to: endPoint,
                headers: requestable.headers?.httpHeaders ?? .default
            ) {
                $0.timeoutInterval = 10
            }
            .responseDecodable(
                of: model.self,
                completionHandler: {  response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(.response(error)))
                    }
                }
            )
        } catch {
            self.requestErrorHandling(error)
            completion(.failure(NetworkingError.wrongRequest))
        }
    }
}

extension Networking {
    private func requestErrorHandling(_ error: Error) {
        guard let error = error as? NetworkingError else {
            debugPrint("** Unhandled error occurs \(error.localizedDescription)")
            return
        }
        
        switch error {
        case .wrongEndpoint:
            debugPrint("** WrongEndPointError occurs")
        case .wrongRequest:
            debugPrint("** WrongRequestError occurs")
        default:
            debugPrint("** UnhandledReuqestError occurs")
        }
    }
}
