//
//  HomeDataStore.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

final class HomeDataStore: ObservableObject {
    @Published var myInfo: MyInfoResponseModel
    @Published var quizs: [QuizSummaryModel]
    @Published var friendsRank: [RankModel]
    @Published var isPresentProgressView: Bool
    
    public init(myInfo: MyInfoResponseModel, quizs: [QuizSummaryModel], friendsRank: [RankModel], isPresentProgressView: Bool) {
        self.myInfo = myInfo
        self.quizs = quizs
        self.friendsRank = friendsRank
        self.isPresentProgressView = isPresentProgressView
    }
}
