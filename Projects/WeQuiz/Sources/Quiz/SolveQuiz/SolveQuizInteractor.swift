//
//  SolveQuizInteractor.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import Foundation

protocol SolveQuizBusinessLogic {
    func loadQuiz(request: SolveQuiz.LoadSolveQuiz.Request)
    func requestQuizResult(request: SolveQuiz.LoadQuizResult.Request)
}

final class SolveQuizInteractor: SolveQuizBusinessLogic {
    
    private var cancellables = Set<AnyCancellable>()
    private let service: QuizService
    
    var presenter: SolveQuizPresentationLogic?
    
    public init(service: QuizService) {
        self.service = service
    }
    
    func loadQuiz(request: SolveQuiz.LoadSolveQuiz.Request) {
        self.service.getQuiz(BaseDataResponseModel<GetQuizResponseModel>.self, QuizAPI.getQuiz(request.quizId))
            .sink(receiveCompletion: { _ in
                //TODO: - Error 처리
            }, receiveValue: { value in
                guard let value else { return }
                let response = SolveQuiz.LoadSolveQuiz.Response(quiz: value)
                self.presenter?.present(response: response)
                
            })
            .store(in: &cancellables)
    }
    
    func requestQuizResult(request: SolveQuiz.LoadQuizResult.Request) {
        self.service.quizResult(BaseDataResponseModel<QuizResultResponseModel>.self, QuizAPI.quizResult(request.quizId, makeRequestModel(request.quiz)))
            .sink(receiveCompletion: { com in
                //TODO: - Error 처리
            }, receiveValue: { value in
                guard let value else { return }
                self.presenter?.presentQuizResult(response: .init(result: value))
            })
            .store(in: &cancellables)
    }
    
    private func makeRequestModel(_ request: SolveQuizModel) ->  QuizResultRequestModel {
        var requestModel = QuizResultRequestModel(answers: [])
        for question in request.questions {
            var answerModel = QuizResultRequestModel.AnswerModel(questionId: question.id, optionIds: [])
            for answer in question.answers {
                if answer.isSelected == true {
                    answerModel.optionIds.append(answer.id)
                }
            }
            requestModel.answers.append(answerModel)
        }
        return requestModel
    }
}
