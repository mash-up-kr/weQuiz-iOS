//
//  MakeQuizConfigurator.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import SwiftUI
import QuizKit
import CoreKit

extension MakeQuizView {
    public func configureView() -> some View {
        var view = self
        let interactor = MakeQuizInteractor(service: QuizService(Networking()))
        let presenter = MakeQuizPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
