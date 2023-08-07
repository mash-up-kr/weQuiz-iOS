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
            
            struct Toast {
                let isWarning: Bool
                let message: String
                
                static let `default`: Toast = .init(isWarning: false, message: "")
            }
        }
        
        struct ViewModel {
            let quizId: Int
            
            struct Toast {
                let isWarning: Bool
                let message: String
                
                static let `default`: Toast = .init(isWarning: false, message: "")
            }
        }
    }
}
