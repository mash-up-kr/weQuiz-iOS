//
//  QuestionDeleteRequestModel.swift
//  HomeKit
//
//  Created by 최원석 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuestionDeleteRequestModel: Codable {
    public var quizId: Int
    
    public init(quizId: Int) {
        self.quizId = quizId
    }
}
