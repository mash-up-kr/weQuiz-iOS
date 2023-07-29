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
    func presentQuizResult(response: SolveQuiz.LoadQuizResult.Response)
}

final class SolveQuizPresenter {
    var view: SolveQuizDisplayLogic?
}

extension SolveQuizPresenter: SolveQuizPresentationLogic {
    func present(response: SolveQuiz.LoadSolveQuiz.Response) {
        view?.displayQuiz(viewModel: .init(quiz: makeViewModel(response)))
    }
    
    func presentQuizResult(response: SolveQuiz.LoadQuizResult.Response) {
        let viewModel = QuizResultModel(myScore: response.result.totalScore, myNickname: response.result.quizResolver.name, friendNickname: response.result.quizCreator.name)
        
        view?.displayQuizResult(viewModel: .init(result: viewModel))
    }
    
    private func makeViewModel(_ response: SolveQuiz.LoadSolveQuiz.Response) -> SolveQuizModel{
        var viewModel = SolveQuizModel.init()
        viewModel.title = response.quiz.title
        for question in response.quiz.questions {
            var questionModel = SolveQuestionModel(id: question.id, title: question.title, answerCount: question.answerCounts, score: question.score, answers: [])
            for answer in question.options {
                questionModel.answers.append(.init(id: answer.id, answer: answer.content, isCorrect: answer.isCorrect))
            }
            viewModel.questions.append(questionModel)
        }
        return viewModel
    }
}
