//
//  SolveQuizConfigurator.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import SwiftUI
import QuizKit
import CoreKit

extension SolveQuizView {
    public func configureView() -> some View {
        var view = self
        let interactor = SolveQuizInteractor(service: QuizService(Networking()))
        let presenter = SolveQuizPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
