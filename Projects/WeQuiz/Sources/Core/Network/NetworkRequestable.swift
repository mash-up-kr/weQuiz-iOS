//
//  NetworkRequestable.swift
//  CoreKit
//
//  Created by AhnSangHoon on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

import Alamofire

public enum NetworkMethod {
    case get
    case post
    case delete
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get: return .get
        case .post: return .post
        case .delete: return .delete
        }
    }
}

public enum NetworkParameterEncoding {
    /// for parmeter
    case urlEncoding
    /// for body
    case jsonEncoding
    
    var parmeterEncoding: ParameterEncoding {
        switch self {
        case .urlEncoding: return URLEncoding.default
        case .jsonEncoding: return JSONEncoding.default
        }
    }
}

public struct NetworkHeader {
    var header: [String: String]
    
    public init(_ header: [String : String]) {
        self.header = header
    }
    
    var httpHeaders: HTTPHeaders {
        .init(header)
    }
    
    static var `default`: NetworkHeader? {
        if let token = AuthManager.shared.token {
            return .init([
                "Content-Type": "application/json",
                "x-wequiz-token": token
            ])
        } else {
            return nil
        }
    }
}

public protocol NetworkRequestable {
    /// Request Path
    var path: String { get }
    /// HttpMethod
    var method: NetworkMethod { get }
    /// Request 시 필요한 parameters
    var parameters: Encodable? { get }
    /// Request Headers
    var headers: NetworkHeader? { get }
    /// Request Encoding
    var encoding: NetworkParameterEncoding { get }
    
    /// Endpoint
    /// -  WrongEndPoint Error를 발생시키기 위해 함수로 작성
    func endpoint() throws -> URL
}

// MARK: - Builder
public extension NetworkRequestable {
    func endpoint() throws -> URL {
        guard let endpoint = URL(string: baseURL + path) else {
            throw Networking.NetworkingError.wrongEndpoint
        }
        return endpoint
    }
}

// MARK: - Preset

public extension NetworkRequestable {
    /// Request 시 사용될 BaseURL
    var baseURL: String {
        "http://wequiz-server-env.eba-c2jfzm3b.eu-north-1.elasticbeanstalk.com"
    }
    
    var path: String {
        ""
    }
    
    var method: NetworkMethod {
        .get
    }
    
    var parameters: Encodable? {
        nil
    }
    
    var headers: NetworkHeader? {
        NetworkHeader.default
    }
    
    var encoding: NetworkParameterEncoding {
        .urlEncoding
    }
}
