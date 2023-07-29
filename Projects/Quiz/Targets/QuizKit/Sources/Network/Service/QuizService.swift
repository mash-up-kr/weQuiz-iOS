//
//  QuizService.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import Combine
import CoreKit

public protocol QuizServiceLogic {
    
    // 퀴즈생성
    func makeQuiz<T>(
        _ model: T.Type,
        _ requestable: CoreKit.NetworkRequestable)
        -> AnyPublisher<MakeQuizResponseModel?, Error> where T : Decodable
    
    // 문제 풀이
    func getQuiz<T>(
        _ model: T.Type,
        _ requestable: CoreKit.NetworkRequestable)
        -> AnyPublisher<GetQuizResponseModel?, Error> where T : Decodable
    
    // 문제 풀이 결과
    func quizResult<T>(
        _ model: T.Type,
        _ requestable: CoreKit.NetworkRequestable)
        -> AnyPublisher<QuizResultResponseModel?, Error> where T : Decodable
    
    // 퀴즈 단건의 랭킹
    func getQuizRank<T>(
        _ model: T.Type,
        _ requestable: CoreKit.NetworkRequestable)
        -> AnyPublisher<GetQuizRankResponseModel?, Error> where T : Decodable

}
public final class QuizService {
    private let networking: NetworkingProtocol
    
    public init(_ networking: NetworkingProtocol) {
        self.networking = networking
    }
}
extension QuizService: QuizServiceLogic {
    public func makeQuiz<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<MakeQuizResponseModel?, Error> where T : Decodable {
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
    
    public func getQuiz<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<GetQuizResponseModel?, Error> where T : Decodable {
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
    
    public func quizResult<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<QuizResultResponseModel?, Error> where T : Decodable {
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
    
    public func getQuizRank<T>(_ model: T.Type, _ requestable: CoreKit.NetworkRequestable) -> AnyPublisher<GetQuizRankResponseModel?, Error> where T : Decodable {
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
}
