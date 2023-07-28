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
    public var quizAnswerCursorId: Int?
    
    public init(size: Int, quizAnswerCursorId: Int?) {
        self.size = size
        self.quizAnswerCursorId = quizAnswerCursorId
    }
}
