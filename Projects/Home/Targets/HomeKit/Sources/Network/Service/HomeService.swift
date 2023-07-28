//
//  HomeService.swift
//  Home
//
//  Created by 최원석 on 2023/07/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import Combine
import CoreKit

public protocol HomeServiceLogic {
    
    func getMyInfo<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T?, Error>
    
    func getFriendRank<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T?, Error>
    
    func getQuestionGroup<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T?, Error>
    
    func getQuestionDetail<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T?, Error>
    
    func deleteQuestion<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<T?, Error>
}

public final class HomeService {
    private let networking: NetworkingProtocol
    
    public init(_ networking: NetworkingProtocol) {
        self.networking = networking
    }
}

extension HomeService: HomeServiceLogic {
    
    public func getMyInfo<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<T?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getFriendRank<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<T?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getQuestionGroup<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<T?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getQuestionDetail<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<T?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func deleteQuestion<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<T?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(T.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}

