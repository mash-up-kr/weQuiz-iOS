//
//  QuizResultModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuizResultModel {
    public let myScore: Int
    public let myNickname: String
    public let friendNickname: String
    public let ranking: [RankUserModel]?
    
    public init(myScore: Int, myNickname: String, friendNickname: String, ranking: [RankUserModel]? = nil) {
        self.myScore = myScore
        self.myNickname = myNickname
        self.friendNickname = friendNickname
        self.ranking = ranking
    }
}

public struct RankUserModel {
    public let id: Int
    public let name: String
    public let score: Int
    
    public init(id: Int, name: String, score: Int) {
        self.id = id
        self.name = name
        self.score = score
    }
}
