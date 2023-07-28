//
//  AuthenticationService.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

import CoreKit

public enum AuthenticationAPIError: Error {
    case fail
}

enum AuthenticationAPI {
    case join(JoinRequestModel)
}

extension AuthenticationAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .join: return "/api/v1/user/join"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .join: return .post
        }
    }
    
    var encoding: NetworkParameterEncoding {
        switch self {
        case .join: return .jsonEncoding
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .join(let model):
            return model
        }
    }
}

public protocol AuthenticationServiceLogic {
    func join(_ model: JoinRequestModel, _ completion: @escaping ((Result<Void, AuthenticationAPIError>)) -> Void)
}

public final class AuthenticationService {
    private let networking: NetworkingProtocol
    
    public init(networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }
}

extension AuthenticationService: AuthenticationServiceLogic {
    public func join(_ model: JoinRequestModel, _ completion: @escaping ((Result<Void, AuthenticationAPIError>)) -> Void) {
        networking.request(EmptyResponseModel.self, AuthenticationAPI.join(model)) { result in
            switch result {
            case .success:
                completion(.success(Void()))
            case .failure:
                completion(.failure(.fail))
            }
        }
    }
}
