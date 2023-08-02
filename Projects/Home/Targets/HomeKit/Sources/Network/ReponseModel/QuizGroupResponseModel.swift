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
    public var nextCursor: Int
    
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


// 서버에서 id값을 int로 내려줄텐데 현재 테스트를 위해서 id값을 임의로 UUID로 설정하여 사용
public var questionSample: QuizGroupResponseModel = QuizGroupResponseModel(quiz: [QuizSummaryModel(id: 0, title: "quiz1"), QuizSummaryModel(id: 1, title: "quiz2"), QuizSummaryModel(id: 2, title: "quiz3"), QuizSummaryModel(id: 3, title: "quiz4"), QuizSummaryModel(id: 4, title: "quiz5")], nextCursor: 0)
