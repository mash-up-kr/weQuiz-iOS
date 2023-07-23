//
//  QuestionDetailModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

struct QuestionDetailModel {
    var id: UUID = UUID()
    var title: String
    var questions: [QuestionModel]
}

struct QuestionModel {
    var id: Int
    var title: String
    var order: Int
    var score: Int
    var answerCounts: Int
    var answers: [AnswerModel]
}

struct AnswerModel {
    var id: Int
    var content: String
    var order: Double
    var isCorrect: Bool
}

extension QuestionDetailModel: Decodable { }

extension QuestionModel: Decodable { }
extension QuestionModel: Identifiable { }

extension AnswerModel: Decodable { }
extension AnswerModel: Identifiable { }

var questionDetailSample: QuestionDetailModel = QuestionDetailModel(title: "퀴즈 타이틀이다.", questions: [QuestionModel(id: 1, title: "흉기차중에서 내가 좋아하는 흉기는?", order: 0, score: 100, answerCounts: 5, answers: [AnswerModel(id: 1, content: "아방가르도", order: 1.0, isCorrect: false), AnswerModel(id: 2, content: "투싼", order: 0.8, isCorrect: false), AnswerModel(id: 3, content: "GV70", order: 0.6, isCorrect: false), AnswerModel(id: 4, content: "쏘렌토", order: 0.4, isCorrect: true), AnswerModel(id: 5, content: "EV9", order: 0.2, isCorrect: false)])])
