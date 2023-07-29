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
    @Published var currentIndex = 0
    @Published var quiz = SolveQuizModel.init()
    @Published var solvedQuiz = SolveQuizModel.init()
    @Published var routeToResultView = false
    @Published var quizResult: QuizResultModel?

    public init() {
        self.quiz = .init()
    }
    
    public func setQuiz(_ quizModel: SolveQuizModel) {
        self.quiz = quizModel
        self.solvedQuiz = quizModel
    }
    
    public func resetQuiz() {
        self.currentIndex = 0
        self.solvedQuiz = self.quiz
    }
    
    public func unselectAnswer() {
        for index in 0..<solvedQuiz.questions[currentIndex].answers.count {
            self.solvedQuiz.questions[currentIndex].answers[index].isSelected = false
        }
    }
    
    public func goToPreviousQuestion() {
        if currentIndex > 0 {
            currentIndex -= 1
            unselectAnswer()
        }
    }

}
