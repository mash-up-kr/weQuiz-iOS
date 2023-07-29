//
//  AuthenticationAPI.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

import CoreKit

public enum AuthenticationAPIError: Error {
    case fail(String)
}

enum AuthenticationAPI {
    case join(JoinRequestModel)
    case user(String)
}

extension AuthenticationAPI: NetworkRequestable {
    var path: String {
        switch self {
        case .join: return "/api/v1/user/join"
        case .user: return "/api/v1/user"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .join: return .post
        case .user: return .get
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .join(let model):
            return model
        case .user:
            return nil
        }
    }
    
    var headers: NetworkHeader? {
        switch self {
        case .join:
            return nil
        case .user(let id):
            return .init([
                "Content-Type": "application/json",
                "x-wequiz-token" : id
            ])
        }
    }
    
    var encoding: NetworkParameterEncoding {
        switch self {
        case .join: return .jsonEncoding
        case .user: return .urlEncoding
        }
    }
}
