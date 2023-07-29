//
//  SolveQuizModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/19.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct SolveQuizModel {
    public var title: String
    public var questions: [SolveQuestionModel]
    
    public init(title: String? = "", questions: [SolveQuestionModel]? = []) {
        self.title = title ?? ""
        self.questions = questions ?? []
    }
}

public struct SolveQuestionModel {
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

public struct SolveAnswerModel {
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
