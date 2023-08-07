//
//  QuizService.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import Foundation

public protocol QuizServiceLogic {
    
    // 퀴즈생성
    func makeQuiz<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<MakeQuizResponseModel?, QuizAPIError> where T : Decodable
    
    // 문제 풀이
    func getQuiz(
        _ requestable: NetworkRequestable,
        _ completion: @escaping (Result<GetQuizResponseModel, QuizAPIError>) -> Void)
    
    // 문제 풀이 결과
    func quizResult<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<QuizResultResponseModel?, QuizAPIError> where T : Decodable
    
    // 퀴즈 단건의 랭킹
    func getQuizRank<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<GetQuizRankResponseModel?, Error> where T : Decodable
}

public final class QuizService {
    private let networking: NetworkingProtocol
    
    public init(_ networking: NetworkingProtocol) {
        self.networking = networking
    }
}
extension QuizService: QuizServiceLogic {
    public func makeQuiz<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable
    ) -> AnyPublisher<MakeQuizResponseModel?, QuizAPIError> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<MakeQuizResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    guard case let .errorMessage(message) = error else {
                        debugPrint(error)
                        promise(.failure(.failure))
                        return
                    }
                    promise(.failure(.failureWithMessage(message)))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getQuiz(
        _ requestable: NetworkRequestable,
        _ completion: @escaping (Result<GetQuizResponseModel, QuizAPIError>) -> Void) {
        networking.request(BaseDataResponseModel<GetQuizResponseModel>.self, requestable, { result in
            switch result {
            case .success(let success):
                guard let model = success else {
                    completion(.failure(.failure))
                    return
                }
                completion(.success(model))
            case .failure(let error):
                guard case .errorMessage(let message) = error else {
                    completion(.failure(.failure))
                    return
                }
                completion(.failure(.failureWithMessage(message)))
            }
        })
    }
    
    public func quizResult<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable
    ) -> AnyPublisher<QuizResultResponseModel?, QuizAPIError> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<QuizResultResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(.failureWithMessage(error.message)))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getQuizRank<T>(_ model: T.Type, _ requestable: NetworkRequestable) -> AnyPublisher<GetQuizRankResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<GetQuizRankResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getTemporaryToken(nickname: String) async -> TemporaryTokenResponseModel? {
        switch await networking.request(
            BaseDataResponseModel<TemporaryTokenResponseModel>.self,
            QuizAPI.anonymous(.init(nickname: nickname))
        ) {
        case .success(let model):
            return model
        case .failure(let error):
            print(error.message)
            return nil
        }
    }
}
