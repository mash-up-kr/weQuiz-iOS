//
//  SolveQuizModel.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

enum SolveQuiz {
    enum LoadSolveQuiz {
        struct Request {
            let quizId: Int
        }
        
        struct Response {
            let quiz: GetQuizResponseModel
            
            static let `default`: Response = .init(quiz: .default)
        }
        
        struct ViewModel {
            let quiz: SolveQuizModel
        }
    }
    
    enum LoadQuizResult {
        struct Request {
            let quizId: Int
            let quiz: SolveQuizModel
        }
        
        struct Response {
            let result: QuizResultResponseModel
        }
        
        struct ViewModel {
            let result: QuizResultModel
        }
    }
}
