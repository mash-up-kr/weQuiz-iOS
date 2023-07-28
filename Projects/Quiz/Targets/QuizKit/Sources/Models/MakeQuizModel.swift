//
//  QuestionModel.swift
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

public struct MakeQuestionModel: Identifiable {
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
}

public struct MakeAnswerModel {
    public var answer: String
    public var isCorrect: Bool
    
    public init(answer: String = "", isCorrect: Bool = false) {
        self.answer = answer
        self.isCorrect = isCorrect
    }
}
