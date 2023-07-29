//
//  SolveQuizPresenter.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation
import QuizKit

protocol SolveQuizPresentationLogic {
    func present(response: SolveQuiz.LoadSolveQuiz.Response)
}

final class SolveQuizPresenter {
    typealias Response = SolveQuiz.LoadSolveQuiz.Response
    typealias ViewModel = SolveQuiz.LoadSolveQuiz.ViewModel
    var view: SolveQuizDisplayLogic?
}

extension SolveQuizPresenter: SolveQuizPresentationLogic {
    func present(response: Response) {
        view?.displayQuiz(viewModel: .init(quiz: makeViewModel(response)))
    }
    
    private func makeViewModel(_ response: Response) -> SolveQuizModel{
        var viewModel = SolveQuizModel.init()
        viewModel.title = response.quiz.title
        for question in response.quiz.questions {
            var questionModel = SolveQuestionModel(title: question.title, answerCount: question.answerCounts, answers: [])
            for answer in question.options {
                questionModel.answers.append(.init(answer: answer.content, isCorrect: answer.isCorrect))
            }
            viewModel.questions.append(questionModel)
        }
        return viewModel
    }
}
