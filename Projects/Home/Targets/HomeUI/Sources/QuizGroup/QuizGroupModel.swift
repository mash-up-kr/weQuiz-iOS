//
//  QuestionGroupModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit

public enum QuizGroupResult {
    enum LoadQuizGroup {
        struct Request {
            let quizGroupRequest: QuizGroupRequestModel
        }
        
        struct Response {
            let quizGroupResponse: QuizGroupResponseModel
        }
        
        struct ViewModel {
            let quizs: [QuizSummaryModel]
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
