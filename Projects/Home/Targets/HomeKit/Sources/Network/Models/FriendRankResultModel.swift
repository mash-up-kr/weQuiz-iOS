//
//  FriendRankResultModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct RankModel: Identifiable {
    public let id: Int
    public let name: String
    public let rank: Int
    public let score: Int
    
    public init(id: Int, name: String, rank: Int, score: Int) {
        self.id = id
        self.name = name
        self.rank = rank
        self.score = score
    }
}

