//
//  QuizResultConfigurator.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import SwiftUI

extension QuizResultView {
    func configureView() -> some View {
        var view = self
        let interactor = QuizResultInteractor()
        let presenter = QuizResultPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
