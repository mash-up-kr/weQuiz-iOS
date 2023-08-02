//
//  QuizResultPresenter.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

protocol QuizResultPresentationLogic {
    func presentRanking(response: QuizResult.LoadRanking.Response)
}

final class QuizResultPresenter {
    var view: QuizResultDisplayLogic?
}

extension QuizResultPresenter: QuizResultPresentationLogic {
    func presentRanking(response: QuizResult.LoadRanking.Response) {
        var viewModel: [RankUserModel] = []
        for (idx, rank) in response.result.rankings.enumerated() {
            viewModel.append(.init(id: rank.userInfoDto.id, name: rank.userInfoDto.name, rank: (idx + 1), score: rank.score))
        }
        view?.displayRanking(viewModel: .init(rank: viewModel))
    }
}
