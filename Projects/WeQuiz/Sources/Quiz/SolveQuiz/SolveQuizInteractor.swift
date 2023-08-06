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
    func requestQuizResult(request: SolveQuiz.LoadQuizResult.Request)
    func requestQuizResultForAnonymous(request: SolveQuiz.LoadQuizResult.Request, temporaryToken: String)
}

final class SolveQuizInteractor: SolveQuizBusinessLogic {
    private var cancellables = Set<AnyCancellable>()
    private let service: QuizService
    
    var presenter: SolveQuizPresentationLogic?
    
    public init(service: QuizService) {
        self.service = service
    }
    
    func requestQuizResult(request: SolveQuiz.LoadQuizResult.Request) {
        self.service.quizResult(
            BaseDataResponseModel<QuizResultResponseModel>.self,
            QuizAPI.quizResult(request.quizId, makeRequestModel(request.quiz))
        )
            .sink(receiveCompletion: { com in
                //TODO: - Error 처리
            }, receiveValue: { value in
                guard let value else { return }
                self.presenter?.presentQuizResult(response: .init(result: value))
            })
            .store(in: &cancellables)
    }
    
    func requestQuizResultForAnonymous(request: SolveQuiz.LoadQuizResult.Request, temporaryToken: String) {
        self.service.quizResult(
            BaseDataResponseModel<QuizResultResponseModel>.self,
            QuizAPI.quizResultForAnonymous(request.quizId, makeRequestModel(request.quiz), temporaryToken)
        )
        .sink(receiveCompletion: { com in
            //TODO: - Error 처리
        }, receiveValue: { value in
            guard let value else { return }
            self.presenter?.presentQuizResult(response: .init(result: value))
        })
        .store(in: &cancellables)
    }
}

extension SolveQuizInteractor {
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
