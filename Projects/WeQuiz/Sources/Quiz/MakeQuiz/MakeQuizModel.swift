//
//  MakeQuizModel.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

enum MakeQuiz {
    enum RequestMakeQuiz {
        struct Request {
            let quiz: MakeQuizModel
        }
        
        struct Response {
            let quizId: Int
        }
        
        struct ViewModel {
            let quizId: Int
        }
    }
}
