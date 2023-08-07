//
//  HomePresenter.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

protocol HomePresentingLogic {
    func present(response: HomeResult.LoadMyInfo.Response)
    func present(response: HomeResult.LoadRanking.Response)
    func present(response: HomeResult.LoadQuizGroup.Response)
    func present(response: HomeResult.Indicator.Response)
}

final class HomePresenter {
    var view: HomeDisplayLogic?
}

extension HomePresenter: HomePresentingLogic {
    func present(response: HomeResult.LoadMyInfo.Response) {
        let viewModel = response.result
        view?.displayMyInfo(viewModel: .init(myInfo: viewModel))
    }
    
    func present(response: HomeResult.LoadRanking.Response) {
        var viewModel: [RankModel] = []
        for (idx, rank) in response.result.rankings.enumerated() {
            viewModel.append(RankModel(id: rank.userInfoDto.id, name: rank.userInfoDto.name, rank: (idx + 1), score: rank.score))
        }
        view?.displayFriendRank(viewModel: .init(rank: viewModel))
    }
    
    func present(response: HomeResult.LoadQuizGroup.Response) {
        let viewModel: [QuizSummaryModel] = response.result.quiz
        view?.displayQuizGroup(viewModel: .init(quizs: viewModel))
    }
    
    func present(response: HomeResult.Indicator.Response) {
        view?.displayIndicator(viewModel: .init(needShow: response.needShow))
    }
}
