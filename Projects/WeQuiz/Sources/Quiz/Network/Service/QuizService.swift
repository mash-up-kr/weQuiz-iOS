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
        -> AnyPublisher<MakeQuizResponseModel?, Error> where T : Decodable
    
    // 문제 풀이
    func getQuiz<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<GetQuizResponseModel?, Error> where T : Decodable
    
    // 문제 풀이
    func getQuiz(
        _ requestable: NetworkRequestable,
        _ completion: @escaping (GetQuizResponseModel?) -> Void)
    
    // 문제 풀이 결과
    func quizResult<T>(
        _ model: T.Type,
        _ requestable: NetworkRequestable)
        -> AnyPublisher<QuizResultResponseModel?, Error> where T : Decodable
    
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
    public func makeQuiz<T>(_ model: T.Type, _ requestable: NetworkRequestable) -> AnyPublisher<MakeQuizResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<MakeQuizResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getQuiz<T>(_ model: T.Type, _ requestable: NetworkRequestable) -> AnyPublisher<GetQuizResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<GetQuizResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func getQuiz(_ requestable: NetworkRequestable, _ completion: @escaping (GetQuizResponseModel?) -> Void) {
        networking.request(BaseDataResponseModel<GetQuizResponseModel>.self, requestable, { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure:
                completion(nil)
            }
        })
    }
    
    public func quizResult<T>(_ model: T.Type, _ requestable: NetworkRequestable) -> AnyPublisher<QuizResultResponseModel?, Error> where T : Decodable {
        return Future { [weak self] promise in
            self?.networking.request(BaseDataResponseModel<QuizResultResponseModel>.self, requestable) { result in
                switch result {
                case .success(let success):
                    promise(.success(success))
                case .failure(let error):
                    promise(.failure(error))
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
