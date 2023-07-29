//
//  FriendRankRequestModel.swift
//  HomeKit
//
//  Created by 최원석 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct FriendRankRequestModel: Codable {
    public var size: Int
    public var cursorScore: Int?
    public var cursorUserId: Int?
    
    public init(size: Int = 15, cursorScore: Int?, cursorUserId: Int?) {
        self.size = size
        self.cursorScore = cursorScore
        self.cursorUserId = cursorUserId
    }
}
