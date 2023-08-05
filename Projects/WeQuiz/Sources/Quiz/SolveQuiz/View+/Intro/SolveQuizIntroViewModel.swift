//
//  SolveQuizIntroViewModel.swift
//  WeQuiz
//
//  Created by AhnSangHoon on 2023/08/04.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import Foundation

final class SolveQuizIntroViewModel: ObservableObject {
    @Published var quizModel: SolveQuiz.LoadSolveQuiz.Response = .default
    @Published var isRemovedQuiz: Bool = false
    private let quizService: QuizService = QuizService(Networking())

    func loadQuiz(id: Int) {
        quizService.getQuiz(QuizAPI.getQuiz(id)) { [weak self] model in
            guard let model = model else { return }
            
            self?.quizModel = SolveQuiz.LoadSolveQuiz.Response(quiz: model)
        }
    }
    
    func makeQuizModel() -> SolveQuizModel {
        SolveQuizModel(
            title: quizModel.quiz.title,
            questions: quizModel.quiz.questions.map { question in
                SolveQuestionModel(
                    id: question.id,
                    title: question.title,
                    answerCount: question.answerCounts,
                    score: question.score,
                    answers: question.options.map { option in
                        SolveAnswerModel.init(
                            id: option.id,
                            answer: option.content,
                            isCorrect: option.isCorrect
                        )
                    })
            }
        )
    }
}
