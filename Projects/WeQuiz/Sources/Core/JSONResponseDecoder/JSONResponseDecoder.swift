//
//  JSONResponseDecoder.swift
//  CoreKit
//
//  Created by AhnSangHoon on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

protocol JSONResponseDecodable {
    func deocde<T: Decodable>(_: T.Type, _ jsonData: Data, _ completion: @escaping ((Result<T?, Error>) -> ()))
}

struct JSONResponseDecoder {
    enum JSONResponseDecoderError: Error {
        case decodeFailed
    }
}

extension JSONResponseDecoder: JSONResponseDecodable {
    func deocde<T: Decodable>(_: T.Type, _ jsonData: Data, _ completion: @escaping ((Result<T?, Error>) -> ()))  {
        do {
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            completion(.success(result))
        } catch (let error) {
            debugPrint("Error: JSONDecode \(error)")
            completion(.failure(JSONResponseDecoderError.decodeFailed))
        }
    }
}
