//
//  Question.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

struct QuestionGroupModel {
    var quiz: [SummaryQuestionModel]
    var nextCursor: Int
}

struct SummaryQuestionModel {
    var id: UUID = UUID()
    var title: String
}

extension QuestionGroupModel: Decodable { }
extension QuestionGroupModel: Equatable { }

extension SummaryQuestionModel: Decodable { }
extension SummaryQuestionModel: Identifiable { }
extension SummaryQuestionModel: Equatable { }


// 서버에서 id값을 int로 내려줄텐데 현재 테스트를 위해서 id값을 임의로 UUID로 설정하여 사용
var questionSample: QuestionGroupModel = QuestionGroupModel(quiz: [SummaryQuestionModel(title: "quiz1"), SummaryQuestionModel(title: "quiz2"), SummaryQuestionModel(title: "quiz3"), SummaryQuestionModel(title: "quiz4"), SummaryQuestionModel(title: "quiz5")], nextCursor: 0)
