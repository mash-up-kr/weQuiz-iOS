//
//  HomeModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum HomeResult {
    enum LoadMyInfo {
        struct Response {
            let result: MyInfoResponseModel
        }
        
        struct ViewModel {
            let myInfo: MyInfoResponseModel
        }
    }
    
    enum LoadRanking {
        struct Request {
            let request: FriendRankRequestModel
        }
        
        struct Response {
            let result: FriendRankResponseModel
        }
        
        struct ViewModel {
            let rank: [RankModel]
        }
    }
    
    enum LoadQuizGroup {
        struct Request {
            let quizGroupRequest: QuizGroupRequestModel
        }
        
        struct Response {
            let result: QuizGroupResponseModel
        }
        
        struct ViewModel {
            let quizs: [QuizSummaryModel]
        }
    }
}
