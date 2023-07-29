//
//  QuizResultPresenter.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation

protocol QuizResultPresentationLogic {
    func present(response: QuizResult.LoadQuizResult.Response)
}

final class QuizResultPresenter {
    typealias Response = QuizResult.LoadQuizResult.Response
    typealias ViewModel = QuizResult.LoadQuizResult.ViewModel
    var view: QuizResultDisplayLogic?
}

extension QuizResultPresenter: QuizResultPresentationLogic {
    func present(response: Response) {
    //    view?.display(viewModel: viewModel)
    }
}