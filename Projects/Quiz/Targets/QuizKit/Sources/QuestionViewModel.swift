//
//  QuestionViewModel.swift
//  QuizKit
//
//  Created by 박소현 on 2023/07/15.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public class QuestionViewModel: ObservableObject {
    @Published public var model: [QuestionModel] = []
    
    public init() {
        self.model = [QuestionModel(), QuestionModel()]
    }
}
