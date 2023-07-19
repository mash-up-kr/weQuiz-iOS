//
//  QuestionViewModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/15.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public class QuestionViewModel: ObservableObject {
    @Published public var quiz: QuizModel
    
    public init() {
        self.quiz = .init()
    }
    
    public func toggleExpand(_ index: UUID) {
        for i in 0..<quiz.questions.count {
            if quiz.questions[i].id == index { continue }
            quiz.questions[i].isExpand = false
        }
    }
}
