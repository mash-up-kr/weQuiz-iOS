//
//  SolveQuizPresenter.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

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
        let viewModel = QuizResultModel(myScore: response.result.totalScore, myNickname: response.result.quizResolver.name, friendNickname: response.result.quizCreator.name,
                                        resultImage: setResultImage(response.result.totalScore),
                                        scoreDescription: setScoreDescription(response.result.totalScore))
        
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
    
    private func setResultImage(_ score: Int) -> String {
        switch score {
        case 90...100:
            return "quizResult_1"
        case 70..<90:
            return "quizResult_2"
        case 50..<70:
            return "quizResult_3"
        case 30..<50:
            return "quizResult_4"
        default:
            return "quizResult_5"
        }
    }
    
    private func setScoreDescription(_ score: Int) -> String {
        switch score {
        case 90...100:
            return "영혼을 공유한 사이 🩷"
        case 70..<90:
            return "찐친 그자체라구!"
        case 50..<70:
            return "우리 정도면 친한편이지?"
        case 30..<50:
            return "그냥 얼굴만 아는 사이..."
        default:
            return "지금 싸우자는 거지?"
        }
    }
}