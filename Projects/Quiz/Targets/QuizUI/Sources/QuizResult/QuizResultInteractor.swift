//
//  QuizResultInteractor.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation
import Combine
import CoreKit
import QuizKit

protocol QuizResultBusinessLogic {
    func requestRanking(request: QuizResult.LoadRanking.Request)
}

final class QuizResultInteractor: QuizResultBusinessLogic {
    
    private var cancellables = Set<AnyCancellable>()
    private let service: QuizService
    
    var presenter: QuizResultPresentationLogic?
    
    public init(service: QuizService) {
        self.service = service
    }
    
    func requestRanking(request: QuizResult.LoadRanking.Request) {
        self.service.getQuizRank(BaseDataResponseModel<GetQuizRankResponseModel>.self, QuizAPI.getQuizRank(request.quizId, GetQuizRankRequestModel(size: 10)))
            .sink(receiveCompletion: { com in
                // TODO: Error 처리
            }, receiveValue: { value in
                guard let value else { return }
                // TODO: 스크롤 되게...
                self.presenter?.presentRanking(response: .init(result: value))
            })
            .store(in: &cancellables)
    }
}
