//
//  QuizModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/06/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct MakeQuizModel {
    public var title: String
    public var questions: [MakeQuestionModel]
    
    public init() {
        self.title = ""
        self.questions = [MakeQuestionModel(), MakeQuestionModel()]
    }
}

public struct MakeQuestionModel: Identifiable, Equatable {
    public var id: UUID = UUID()
    public var title: String
    public var answers: [MakeAnswerModel]
    public var duplicatedOption: Bool = false
    public var isExpand: Bool = false
    
    public init(title: String = "") {
        self.title = title
        self.answers = [MakeAnswerModel(answer: "", isCorrect: false),
                        MakeAnswerModel(answer: "", isCorrect: false)]
    }
    
    public func checkQuestionFilled() -> Bool {
        let answerCount = answers.filter({ $0.isCorrect == true })
        let answerIsEmpty = answers.filter({ $0.answer.isEmpty == true })
        
        if title.isEmpty == true || answerCount.count == 0 || answerIsEmpty.count > 0 {
            return false
        }
        return true
    }
}

public struct MakeAnswerModel: Equatable {
    public var answer: String
    public var isCorrect: Bool
    
    public init(answer: String = "", isCorrect: Bool = false) {
        self.answer = answer
        self.isCorrect = isCorrect
    }
}

// MARK: - QuizResultModel

// QuizResultModel.swift 로 만들어져 있었지만, 파일명 충돌로 인해 임시로 현재 파일로 통합
public struct QuizResultModel {
    public let myScore: Int
    public let myNickname: String
    public let friendNickname: String
    public let resultImage: String
    public let scoreDescription: String
    public var ranking: [RankUserModel]?
    
    public init(myScore: Int, myNickname: String, friendNickname: String, resultImage: String, scoreDescription: String, ranking: [RankUserModel]? = nil) {
        self.myScore = myScore
        self.myNickname = myNickname
        self.friendNickname = friendNickname
        self.resultImage = resultImage
        self.scoreDescription = scoreDescription
        self.ranking = ranking
    }
}

public struct RankUserModel {
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

// MARK: - SolveQuizModel

// SolveQuizModel.swift 로 만들어져 있었지만, 파일명 충돌로 인해 임시로 현재 파일로 통합

public struct SolveQuizModel: Equatable, Hashable {
    public var title: String
    public var questions: [SolveQuestionModel]
    
    public init(title: String? = "", questions: [SolveQuestionModel]? = []) {
        self.title = title ?? ""
        self.questions = questions ?? []
    }
}

public struct SolveQuestionModel: Equatable, Hashable {
    public var id: Int
    public var title: String
    public var answerCount: Int
    public var score: Int
    public var answers: [SolveAnswerModel]
    
    public init(id: Int, title: String, answerCount: Int, score: Int, answers: [SolveAnswerModel]) {
        self.id = id
        self.title = title
        self.answerCount = answerCount
        self.score = score
        self.answers = answers
    }
}

public struct SolveAnswerModel: Equatable, Hashable {
    public var id: Int
    public var answer: String
    public var isSelected: Bool
    public var isCorrect: Bool
    
    public init(id: Int, answer: String, isCorrect: Bool) {
        self.id = id
        self.answer = answer
        self.isSelected = false
        self.isCorrect = isCorrect
    }
}

