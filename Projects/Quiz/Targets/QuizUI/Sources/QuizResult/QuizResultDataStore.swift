//
//  QuizResultDataStore.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import Foundation
import QuizKit

final class QuizResultDataStore: ObservableObject {
    @Published var quizId: Int?
    @Published var result: QuizResultModel?
    
    public init() {}
}
