//
//  QuizDetailConfigurator.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

extension QuizDetailView {
    public func configureView(quizId: Int) -> some View {
        var view = self
        let interactor = QuizDetailInteractor(service: HomeService(Networking()))
        let presenter = QuizDetailPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        
        interactor.getQuizDetail(request: QuizDetailResult.LoadQuizDetail.Request(quizDetailRequest: QuizDetailRequestModel(quizId: quizId)))
        return view
    }
}
