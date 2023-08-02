//
//  QuizResultConfigurator.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import SwiftUI

extension QuizResultView {
    public func configureView() -> some View {
        var view = self
        let interactor = QuizResultInteractor(service: QuizService(Networking()))
        let presenter = QuizResultPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
