//
//  Question.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct QuestionGroupModel {
    public var quiz: [SummaryQuestionModel]
    public var nextCursor: Int
    
    public init(quiz: [SummaryQuestionModel], nextCursor: Int) {
        self.quiz = quiz
        self.nextCursor = nextCursor
    }
}

public struct SummaryQuestionModel {
    public var id: Int
    public var title: String
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

extension QuestionGroupModel: Decodable { }
extension QuestionGroupModel: Equatable { }

extension SummaryQuestionModel: Decodable { }
extension SummaryQuestionModel: Identifiable { }
extension SummaryQuestionModel: Equatable { }


// 서버에서 id값을 int로 내려줄텐데 현재 테스트를 위해서 id값을 임의로 UUID로 설정하여 사용
public var questionSample: QuestionGroupModel = QuestionGroupModel(quiz: [SummaryQuestionModel(id: 0, title: "quiz1"), SummaryQuestionModel(id: 1, title: "quiz2"), SummaryQuestionModel(id: 2, title: "quiz3"), SummaryQuestionModel(id: 3, title: "quiz4"), SummaryQuestionModel(id: 4, title: "quiz5")], nextCursor: 0)
