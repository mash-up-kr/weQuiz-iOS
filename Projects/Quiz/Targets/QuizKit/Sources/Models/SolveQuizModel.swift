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
    
    public init(title: String, questions: [SolveQuestionModel]) {
        self.title = ""
        self.questions = questions
    }
}

public struct SolveQuestionModel: Identifiable {
    public var id: UUID = UUID()
    public var title: String
    public var answerCount: Int
    public var answers: [SolveAnswerModel]
    
    public init(title: String, answerCount: Int, answers: [SolveAnswerModel]) {
        self.title = title
        self.answerCount = answerCount
        self.answers = answers
    }
}

public class SolveAnswerModel: Identifiable, ObservableObject {
    public var id = UUID()
    public var answer: String
    public var order: Int
    @Published public var isSelected: Bool
    public var isCorrect: Bool
    
    public init(answer: String, order: Int, isCorrect: Bool) {
        self.answer = answer
        self.order = order
        self.isSelected = false
        self.isCorrect = isCorrect
    }
}
