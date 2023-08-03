//
//  QuestionGroupConfigurator.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

extension QuizGroupView {
    public func configureView() -> some View {
        var view = self
        let interactor = QuizGroupInteractor(service: HomeService(Networking()))
        let presenter = QuizGroupPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}