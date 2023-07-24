//
//  HomeRequestModel.swift
//  HomeKit
//
//  Created by 최원석 on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct FriendRankRequestModel: Codable {
    var size: Int
    var quizId: Int
}

public struct QuestionGroupRequestModel: Codable {
    var size: Int
    var cursor: Int
}

public struct QuestionStatisticRequestModel: Codable {
    var quizId: Int
}

public struct QuestionDeleteRequestModel: Codable {
    var quizId: Int
}

