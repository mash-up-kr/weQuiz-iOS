//
//  QuestionGroupPresenter.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

protocol QuizGroupPresentingLogic {
    func present(response: QuizGroupResult.LoadQuizGroup.Response)
    func present(response: QuizGroupResult.DeleteQuiz.Response)
}

final class QuizGroupPresenter {
    var view: QuizGroupDisplayLogic?
}

extension QuizGroupPresenter: QuizGroupPresentingLogic {
    func present(response: QuizGroupResult.DeleteQuiz.Response) {
        var viewModel: Bool = response.deleteResponse.isDeleted
        view?.deleteQuiz(viewModel: .init(isDeleted: viewModel))
    }
    
    func present(response: QuizGroupResult.LoadQuizGroup.Response) {
        var viewModel: [QuizSummaryModel] = response.quizGroupResponse.quiz
        view?.displayQuizGroup(viewModel: .init(quizs: viewModel))
    }
}
