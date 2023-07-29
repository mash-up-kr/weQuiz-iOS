//
//  QuizRequestModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct MakeQuizRequestModel: Codable {
    public let title: String
    public let questions: [QuestionModel]
    
    public init(title: String, questions: [QuestionModel]) {
        self.title = title
        self.questions = questions
    }
    
    public struct QuestionModel: Codable {
        public let title: String
        public let duplicatedOption: Bool
        public let options: [AnswerModel]

        public init(title: String, duplicatedOption: Bool, options: [AnswerModel]) {
            self.title = title
            self.duplicatedOption = duplicatedOption
            self.options = options
        }

        public struct AnswerModel: Codable {
            public let content: String
            public let isCorrect: Bool

            public init(content: String, isCorrect: Bool) {
                self.content = content
                self.isCorrect = isCorrect
            }
        }
    }
}

public struct QuizResultRequestModel: Codable {
    public var answers: [AnswerModel]
    
    public init(answers: [AnswerModel]?) {
        self.answers = answers ?? []
    }
    
    public struct AnswerModel: Codable {
        public var questionId: Int
        public var optionIds: [Int]
        
        public init(questionId: Int, optionIds: [Int]?) {
            self.questionId = questionId
            self.optionIds = optionIds ?? []
        }
    }
}

public struct GetQuizRankRequestModel: Codable {
    public let size: Int
    public let quizAnswerCursorId: Int?
    
    public init(size: Int, quizAnswerCursorId: Int? = nil) {
        self.size = size
        self.quizAnswerCursorId = quizAnswerCursorId
    }
}
