//
//  SolveQuizInteractor.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation
import Combine
import CoreKit
import QuizKit

protocol SolveQuizBusinessLogic {
    func loadQuiz(request: SolveQuiz.LoadSolveQuiz.Request)
}

final class SolveQuizInteractor: SolveQuizBusinessLogic {
    private var cancellables = Set<AnyCancellable>()
    private let service: QuizService
    
    var presenter: SolveQuizPresentationLogic?
    
    public init(service: QuizService) {
        self.service = service
    }
    
    func loadQuiz(request: SolveQuiz.LoadSolveQuiz.Request) {
        self.service.getQuiz(GetQuizResponseModel.self, QuizAPI.getQuiz(request.quizId))
            .sink(receiveCompletion: { _ in
                //TODO: - Error 처리
            }, receiveValue: { value in
                guard let value else { return }
                let response = SolveQuiz.LoadSolveQuiz.Response(quiz: value)
                self.presenter?.present(response: response)
                
            })
            .store(in: &cancellables)
    }
}
