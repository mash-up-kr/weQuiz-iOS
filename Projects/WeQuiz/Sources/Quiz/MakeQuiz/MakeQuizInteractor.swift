//
//  MakeQuizInteractor.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import Foundation

protocol MakeQuizBusinessLogic {
    func requestMakeQuiz(request: MakeQuiz.RequestMakeQuiz.Request)
}

final class MakeQuizInteractor: MakeQuizBusinessLogic {
    private var cancellables = Set<AnyCancellable>()
    private let service: QuizService
    
    var presenter: MakeQuizPresentationLogic?
    
    public init(service: QuizService) {
        self.service = service
    }
    
    func requestMakeQuiz(request: MakeQuiz.RequestMakeQuiz.Request) {
        self.service.makeQuiz(BaseDataResponseModel<MakeQuizResponseModel>.self, QuizAPI.makeQuiz(makeRequestModel(request)))
            .sink(receiveCompletion: { _ in
                // TODO: Error 처리
            }, receiveValue: { value in
                guard let value else { return }
                let response = MakeQuiz.RequestMakeQuiz.Response(quizId: value.quizId)
                self.presenter?.presentMakeQuiz(response: response)
            })
            .store(in: &cancellables)
    }
    
    private func makeRequestModel(_ request: MakeQuiz.RequestMakeQuiz.Request) -> MakeQuizRequestModel {
        var questions: [MakeQuizRequestModel.QuestionModel] = []
        for question in request.quiz.questions {

            var answers: [MakeQuizRequestModel.QuestionModel.AnswerModel] = []

            for answer in question.answers {
                answers.append(.init(content: answer.answer, isCorrect: answer.isCorrect))
            }
            questions.append(.init(title: question.title, duplicatedOption: question.duplicatedOption, options: answers))
        }
        return MakeQuizRequestModel(title: request.quiz.title, questions: questions)
    }
}
