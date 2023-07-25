//
//  NetworkRequestable.swift
//  CoreKit
//
//  Created by AhnSangHoon on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

import Alamofire

public protocol NetworkRequestable {
    /// Request Path
    var path: String { get }
    /// HttpMethod
    var method: HTTPMethod { get }
    /// Request 시 필요한 parameters
    var parameters: Encodable? { get }
    /// Request Headers
    var headers: HTTPHeaders { get }
    /// Request Encoding
    var encoding: ParameterEncoding { get }
    
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
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Encodable? {
        nil
    }
    
    var headers: HTTPHeaders {
        .default
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.default
    }
}


