//
//  SolveQuizDataStore.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation
import QuizKit

final class SolveQuizDataStore: ObservableObject {    
    // Output
    @Published public var quiz = SolveQuizModel.init()

    public init() {
        self.quiz = .init()
    }
    
    
}
