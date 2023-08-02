//
//  FriendRankModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit

public enum FriendRankResult {
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
}
