//
//  QuestionModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/06/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuestionModel: Identifiable {
    public var id: UUID = UUID()
    public var title: String?
    public var answers: [AnswerModel]
    
    public init(title: String? = nil) {
        self.title = title
        self.answers = [AnswerModel(answer: "", isCorrect: false),
                        AnswerModel(answer: "", isCorrect: false)]
    }
}

public struct AnswerModel {
    public var answer: String
    public var isCorrect: Bool
    
    public init(answer: String = "", isCorrect: Bool = false) {
        self.answer = answer
        self.isCorrect = isCorrect
    }
}
