//
//  QuestionDeleteModel.swift
//  HomeKit
//
//  Created by 최원석 on 2023/07/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuestionDeleteModel {
    public var isDeleted: Bool
    
    public init(isDeleted: Bool) {
        self.isDeleted = isDeleted
    }
}

extension QuestionDeleteModel: Decodable { }
