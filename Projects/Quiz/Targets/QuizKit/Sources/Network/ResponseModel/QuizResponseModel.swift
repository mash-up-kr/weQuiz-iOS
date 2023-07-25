//
//  QuizResponseModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct MakeQuizResponseModel: Decodable {
    public let quizId: Int
    
    public init(quizId: Int) {
        self.quizId = quizId
    }
}

public struct GetQuizResponseModel: Decodable {
    public let quizCreator: User
    public let quizResolver: User
    public let totalScore: Int
    
    public init(quizCreator: User, quizResolver: User, totalScore: Int) {
        self.quizCreator = quizCreator
        self.quizResolver = quizResolver
        self.totalScore = totalScore
    }
    
    
}

public struct GetQuizRankResponseModel: Decodable {
    public let hasNext: Bool
    public let cursorQuizAnswerId: Int
    public let rankings: [RankModel]
    
    public init(hasNext: Bool, cursorQuizAnswerId: Int, rankings: [RankModel]) {
        self.hasNext = hasNext
        self.cursorQuizAnswerId = cursorQuizAnswerId
        self.rankings = rankings
    }
    
    public struct RankModel: Decodable {
        public let userInfoDto: User
        public let score: Int
        public let quizAnswerId: Int

        public init(userInfoDto: User, score: Int, quizAnswerId: Int) {
            self.userInfoDto = userInfoDto
            self.score = score
            self.quizAnswerId = quizAnswerId
        }
    }
}

public struct User: Decodable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
