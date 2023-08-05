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

public struct GetQuizResponseModel: Codable {
    public let id: Int
    public let title: String
    public let questions: [QuiestionModel]
    
    public static let `default`: GetQuizResponseModel = .init(
        id: .zero,
        title: "-",
        questions: []
    )
    
    public init(id: Int, title: String, questions: [QuiestionModel]) {
        self.id = id
        self.title = title
        self.questions = questions
    }
    
    public struct QuiestionModel: Codable {
        public let id: Int
        public let title: String
        public let score: Int
        public let answerCounts: Int
        public let options: [AnswerModel]
        
        public init(id: Int, title: String, score: Int, answerCounts: Int, options: [AnswerModel]) {
            self.id = id
            self.title = title
            self.score = score
            self.answerCounts = answerCounts
            self.options = options
        }
        
        public struct AnswerModel: Codable {
            public let id: Int
            public let content: String
            public let isCorrect: Bool
            
            public init(id: Int, content: String, isCorrect: Bool) {
                self.id = id
                self.content = content
                self.isCorrect = isCorrect
            }
        }
    }
}

public struct QuizResultResponseModel: Decodable {
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
    public let cursorQuizAnswerId: Int?
    public let rankings: [RankModel]
    
    public init(hasNext: Bool, cursorQuizAnswerId: Int? = nil, rankings: [RankModel]) {
        self.hasNext = hasNext
        self.cursorQuizAnswerId = cursorQuizAnswerId
        self.rankings = rankings
    }
    
    public struct RankModel: Decodable {
        public let userInfoDto: User
        public let score: Int

        public init(userInfoDto: User, score: Int) {
            self.userInfoDto = userInfoDto
            self.score = score
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
