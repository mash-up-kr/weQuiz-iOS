//
//  FriendRankDataStore.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit

final class FriendRankDataStore: ObservableObject {
    @Published var result: [RankModel]
    
    public init(result: [RankModel]) {
        self.result = result
    }
}
