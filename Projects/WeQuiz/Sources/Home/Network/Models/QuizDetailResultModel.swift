//
//  QuizDetailResultModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuizDetailViewModel: Identifiable {
    public let quizId: Int
    public let quizTitle: String
    public let questions: [QuestionViewModel]
    
    public var id: Int {
        return quizId
    }
    
    public init(quizId: Int, quizTitle: String, questions: [QuestionViewModel]) {
        self.quizId = quizId
        self.quizTitle = quizTitle
        self.questions = questions
    }
}

public struct QuestionViewModel: Identifiable {
    public let questionId: Int
    public let questionTitle: String
    public let rank: Int
    public let options: [AnswerViewModel]
    
    public var id: Int {
        return questionId
    }
    
    public init(questionId: Int, questionTitle: String, rank: Int, options: [AnswerViewModel]) {
        self.questionId = questionId
        self.questionTitle = questionTitle
        self.rank = rank
        self.options = options
    }
}

public struct AnswerViewModel: Identifiable {
    public var optionId: Int
    public var content: String
    public var isCorrect: Bool
    public var selectivity: Double
    public var rank: Int
    
    public var id: Int {
        return optionId
    }
    
    public init(optionId: Int, content: String, isCorrect: Bool, selectivity: Double, rank: Int) {
        self.optionId = optionId
        self.content = content
        self.isCorrect = isCorrect
        self.selectivity = selectivity
        self.rank = rank
    }
}
