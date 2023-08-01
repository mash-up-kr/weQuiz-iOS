//
//  QuestionGroupRequestModel.swift
//  HomeKit
//
//  Created by 최원석 on 2023/07/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuestionGroupRequestModel: Codable {
    public var size: Int
    public var cursor: Int?
    
    public init(size: Int, cursor: Int?) {
        self.size = size
        self.cursor = cursor
    }
}
