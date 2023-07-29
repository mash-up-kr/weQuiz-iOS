//
//  MakeQuizPresenter.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation

protocol MakeQuizPresentationLogic {
    func presentMakeQuiz(response: MakeQuiz.RequestMakeQuiz.Response)
}

final class MakeQuizPresenter {
    var view: MakeQuizDisplayLogic?
}

extension MakeQuizPresenter: MakeQuizPresentationLogic {
    func presentMakeQuiz(response: MakeQuiz.RequestMakeQuiz.Response) {
        let viewModel = MakeQuiz.RequestMakeQuiz.ViewModel(quizId: response.quizId)
        view?.displayCompletionView(viewModel: viewModel)
    }
}
