//
//  QuizResultInteractor.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation

protocol QuizResultBusinessLogic {
    func load(request: QuizResult.LoadQuizResult.Request)
}

final class QuizResultInteractor {
    typealias Request = QuizResult.LoadQuizResult.Request
    typealias Response = QuizResult.LoadQuizResult.Response
    var presenter: QuizResultPresentationLogic?
}

extension QuizResultInteractor: QuizResultBusinessLogic {
    func load(request: Request) {
        // presenter?.present(response:  Response)
    }
}
