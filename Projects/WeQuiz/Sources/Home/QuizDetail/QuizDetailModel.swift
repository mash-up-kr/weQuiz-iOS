//
//  QuizDetailModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum QuizDetailResult {
    enum LoadQuizDetail {
        struct Request {
            let quizDetailRequest: QuizDetailRequestModel
        }
        
        struct Response {
            let quizDetailResponse: QuizDetailResponseModel
        }
        
        struct ViewModel {
            let quizDetail: QuizDetailViewModel
        }
    }
    
    enum DeleteQuiz {
        struct Request {
            let deleteRequest: QuizDeleteRequestModel
        }
        
        struct Response {
            let deleteResponse: QuizDeleteResponseModel
        }
        
        struct ViewModel {
            let isDeleted: Bool
        }
    }
}
