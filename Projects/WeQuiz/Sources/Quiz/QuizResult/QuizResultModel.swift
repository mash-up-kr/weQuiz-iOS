//
//  QuizResultModel.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

enum QuizResult {
    enum LoadRanking {
        struct Request {
            let quizId: Int
        }
        
        struct Response {
            let result: GetQuizRankResponseModel
        }
        
        struct ViewModel {
            let rank: [RankUserModel]
        }
    }
}
