//
//  QuizDetailPresenter.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit

protocol QuizDetailPresentingLogic {
    func present(response: QuizDetailResult.LoadQuizDetail.Response)
    func present(response: QuizDetailResult.DeleteQuiz.Response)
}

final class QuizDetailPresenter {
    var view: QuizDetailDisplayLogic?
}

extension QuizDetailPresenter: QuizDetailPresentingLogic {
    func present(response: QuizDetailResult.LoadQuizDetail.Response) {
        
        var questionViewModel: [QuestionViewModel] = []
        for (index, content) in response.quizDetailResponse.questions.enumerated() {
            var answerViewModel: [AnswerViewModel] = []
            for (index, content) in content.options.enumerated() {
                answerViewModel.append(AnswerViewModel(optionId: content.optionId, content: content.content, isCorrect: content.isCorrect, selectivity: content.selectivity, rank: (index+1)))
            }
            questionViewModel.append(QuestionViewModel(questionId: content.questionId, questionTitle: content.questionTitle, rank: (index+1), options: answerViewModel))
        }
        
        var viewModel = QuizDetailViewModel(quizId: response.quizDetailResponse.quizId, quizTitle: response.quizDetailResponse.quizTitle, questions: questionViewModel)
        
        view?.displayQuizDetail(viewModel: .init(quizDetail: viewModel))
    }
    
    func present(response: QuizDetailResult.DeleteQuiz.Response) {
        var viewModel: Bool = response.deleteResponse.isDeleted
        view?.deleteQuiz(viewModel: .init(isDeleted: viewModel))
    }
}
