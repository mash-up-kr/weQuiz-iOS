//
//  SolveQuizViewModel.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public class SolveQuizViewModel: ObservableObject {
    @Published public var quiz: SolveQuizModel
    
    // TODO: - 임시 모델
    public init() {
        self.quiz = .init(title: "", questions: [SolveQuestionModel(title: "내가 좋아하는 색은?", answerCount: 2, answers: [SolveAnswerModel(answer: "빨간색", order: 0, isCorrect: false), SolveAnswerModel(answer: "노란색", order: 1, isCorrect: true), SolveAnswerModel(answer: "초록색", order: 2, isCorrect: false)]),
            SolveQuestionModel(title: "오늘의 날씨는?", answerCount: 1, answers: [SolveAnswerModel(answer: "☁️", order: 0, isCorrect: true), SolveAnswerModel(answer: "☔️", order: 1, isCorrect: false), SolveAnswerModel(answer: "☀️", order: 2, isCorrect: false)]),
            SolveQuestionModel(title: "오늘 나의 기분은?", answerCount: 1, answers: [SolveAnswerModel(answer: "좋음", order: 0, isCorrect: false), SolveAnswerModel(answer: "그저그럼", order: 1, isCorrect: true), SolveAnswerModel(answer: "썩음", order: 2, isCorrect: false)])])
    }
}
