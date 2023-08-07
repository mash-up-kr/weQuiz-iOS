//
//  Question.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuizGroupResponseModel {
    public var quiz: [QuizSummaryModel]
    public var nextCursor: Int?
    
    public init(quiz: [QuizSummaryModel], nextCursor: Int) {
        self.quiz = quiz
        self.nextCursor = nextCursor
    }
}

public struct QuizSummaryModel {
    public var id: Int
    public var title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

extension QuizGroupResponseModel: Decodable { }
extension QuizGroupResponseModel: Equatable { }

extension QuizSummaryModel: Decodable { }
extension QuizSummaryModel: Identifiable { }
extension QuizSummaryModel: Equatable { }
