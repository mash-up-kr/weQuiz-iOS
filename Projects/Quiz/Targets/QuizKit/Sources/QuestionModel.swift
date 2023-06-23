//
//  QuestionModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/06/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuestionModel: Identifiable {
    public var id: UUID = UUID()
    public var title: String?
    
    public init(title: String? = nil) {
        self.title = title
    }
}
