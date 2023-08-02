//
//  FriendRankPresenter.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit

protocol FriendRankPresentingLogic {
    func present(response: FriendRankResult.LoadRanking.Response)
}

final class FriendRankPresenter {
    var view: FriendRankDisplayLogic?
}

extension FriendRankPresenter: FriendRankPresentingLogic {
    func present(response: FriendRankResult.LoadRanking.Response) {
        var viewModel: [RankModel] = []
        for (idx, rank) in response.result.rankings.enumerated() {
            viewModel.append(RankModel(id: rank.userInfoDto.id, name: rank.userInfoDto.name, rank: (idx + 1), score: rank.score))
        }
        view?.displayRanking(viewModel: .init(rank: viewModel))
    }
}
