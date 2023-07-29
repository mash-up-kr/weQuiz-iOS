//
//  SolveQuizModel.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation
import QuizKit

enum SolveQuiz {
    enum LoadSolveQuiz {
        struct Request {
            let quizId: Int
        }
        
        struct Response {
            let quiz: GetQuizResponseModel
        }
        
        struct ViewModel {
            let quiz: SolveQuizModel
        }
    }
}
