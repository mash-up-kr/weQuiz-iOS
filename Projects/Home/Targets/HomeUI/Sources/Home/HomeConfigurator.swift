//
//  HomeConfigurator.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit
import CoreKit
import SwiftUI

extension HomeView {
    public func configureView() -> some View {
        var view = self
        let interactor = HomeInteractor(service: HomeService(Networking()))
        let presenter = HomePresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        interactor.getMyInfo()
        interactor.getFriendRank(request: HomeResult.LoadRanking.Request(request: FriendRankRequestModel(size: 15, cursorScore: nil, cursorUserId: nil)))
        interactor.getQuizGroup(request: HomeResult.LoadQuizGroup.Request(quizGroupRequest: QuizGroupRequestModel(size: 15, cursor: nil)))
        
        return view
    }
}
