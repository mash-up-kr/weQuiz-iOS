//
//  MakeQuizDataStore.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

final class MakeQuizDataStore: ObservableObject {
    @Published var quiz: MakeQuizModel
    @Published var routeToCompletionView = false
    
    private let quizNameLimit = 38
    
    public init() {
        self.quiz = .init()
    }
    
    public func toggleExpand(_ index: UUID) {
        for i in 0..<quiz.questions.count {
            if quiz.questions[i].id == index { continue }
            quiz.questions[i].isExpand = false
        }
    }
    
    public func limitQuizName() {
        if quiz.title.count > quizNameLimit {
            quiz.title = String(quiz.title.prefix(quizNameLimit))
        }
    }
    
    public func isQuizFilled() -> Bool {
        if quiz.title.isEmpty == true || quiz.questions.count < 2 {
            return false
        }
        
        for question in quiz.questions {
            if question.title.isEmpty == true {
                return false
            }
            let answerCount = question.answers.filter({ $0.isCorrect == true })
            let answerIsEmpty = question.answers.filter({ $0.answer.isEmpty == true })
            if answerCount.count == 0 || answerIsEmpty.count > 0 {
                return false
            }
        }
        return true
    }
}
