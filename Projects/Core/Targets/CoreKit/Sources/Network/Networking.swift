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
    func request<T:Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Error>) -> ())
    )
    func requestMultipartFormData<T:Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Error>) -> ())
    )
}

public final class Networking: NetworkingProtocol {
    
    public enum NetworkingError: Error {
        case emptyResponse
        case decodingError
        case wrongRequest
        case wrongEndpoint
        case response(AFError)
    }
    
    public init() { }
    
    public func request<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Error>) -> ())
    ) where T : Decodable {
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
            .validate(statusCode: 200..<300)
            .response { response in
                if let error = response.error {
                    completion(.failure(NetworkingError.response(error)))
                }
                guard let data = response.data else {
                    completion(.failure(NetworkingError.emptyResponse))
                    return
                }
                
                self.decode(model, data, { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            completion(.success(success))
                        case .failure(let failure):
                            completion(.failure(failure))
                        }
                    }
                })
            }
        } catch {
            self.requestErrorHandling(error)
            completion(.failure(NetworkingError.wrongRequest))
        }
    }
    
    public func requestMultipartFormData<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable,
        _ completion: @escaping ((Result<T?, Error>) -> ())
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
            .response { response in
                
                if let error = response.error {
                    completion(.failure(NetworkingError.response(error)))
                }
                guard let data = response.data else {
                    completion(.failure(NetworkingError.emptyResponse))
                    return
                }
                
                self.decode(model, data, { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            completion(.success(success))
                        case .failure(let failure):
                            completion(.failure(failure))
                        }
                    }
                })
            }
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
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Data, Error>) -> ()) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.unknownError))
            return
        }
        
        guard (200...299).contains(response.statusCode) else {
            completion(.failure(NetworkError.serverError(ServerError(rawValue: response.statusCode) ?? .unkonown)))
            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkError.emptyData))
            return
        }
        
        completion(.success((data)))
    }
    
    private func decode<T: Decodable>(_: T.Type ,_ data: Data, _ completion: @escaping ((Result<T?, Error>) -> ()))  {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch (let error) {
            debugPrint("Error: JSONDecode \(error)")
            completion(.failure(NetworkingError.decodingError))
        }
    }
}
