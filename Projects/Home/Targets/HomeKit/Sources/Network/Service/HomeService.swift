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
        -> AnyPublisher<MyInfoResponseModel?, Error>
    
    func getFriendRank<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<FriendRankResponseModel?, Error>
    
    func getQuizGroup<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<QuizGroupResponseModel?, Error>
    
    func getQuizDetail<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<QuizDetailResponseModel?, Error>
    
    func deleteQuiz<T: Decodable>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<QuizDeleteResponseModel?, Error>
}

public final class HomeService {
    private let networking: NetworkingProtocol
    
    public init(_ networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }
}

extension HomeService: HomeServiceLogic {
    public func getMyInfo<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<MyInfoResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<MyInfoResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getFriendRank<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<FriendRankResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<FriendRankResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getQuizGroup<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<QuizGroupResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<QuizGroupResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getQuizDetail<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<QuizDetailResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<QuizDetailResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func deleteQuiz<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<QuizDeleteResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<QuizDeleteResponseModel>.self, requestable) { result in
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

