//
//  QuestionStatisticModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuizDetailResponseModel: Decodable, Identifiable {
    public var quizId: Int
    public var quizTitle: String
    public var questions: [QuestionResponseModel]
    
    public var id: Int {
        return quizId
    }
    
    public init(quizId: Int, quizTitle: String, questions: [QuestionResponseModel]) {
        self.quizId = quizId
        self.quizTitle = quizTitle
        self.questions = questions
    }
}

public struct QuestionResponseModel: Decodable, Identifiable {
    public var questionId: Int
    public var questionTitle: String
    public var options: [AnswerResponseModel]
    
    public var id: Int {
        return questionId
    }
    
    public init(questionId: Int, questionTitle: String, options: [AnswerResponseModel]) {
        self.questionId = questionId
        self.questionTitle = questionTitle
        self.options = options
    }
}

public struct AnswerResponseModel: Decodable, Identifiable {
    public var optionId: Int
    public var content: String
    public var isCorrect: Bool
    public var selectivity: Double
    
    public var id: Int {
        return optionId
    }
    
    public init(optionId: Int, content: String, isCorrect: Bool, selectivity: Double) {
        self.optionId = optionId
        self.content = content
        self.isCorrect = isCorrect
        self.selectivity = selectivity
    }
}
