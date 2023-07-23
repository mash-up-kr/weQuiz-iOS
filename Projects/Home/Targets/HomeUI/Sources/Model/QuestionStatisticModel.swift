//
//  QuestionStatisticModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

// 현재 서버에서 QuestionDetail이랑 Statistic이랑 분리를 해놓았는데 이것을 하나로 묶을 필요가 있다.
struct QuestionStatisticModel: Decodable {
    var quizInfo: QuizInfoModel
    var statistic: QuizStatisticModel
}

struct QuizInfoModel: Decodable, Identifiable {
    var quizId: Int
    var quizTitle: String
    var questions: [QuestionOnStatisticModel]
    var id: Int {
        return quizId
    }
}

struct QuestionOnStatisticModel: Decodable {
    var title: String
    var priorty: Int
    var duplicatedOption: Bool
    var options: [AnswerModel]
}

struct QuizStatisticModel: Decodable, Identifiable {
    var questionId: Int
    var options: [AnswerStaticModel]
    var id: Int {
        return questionId
    }
}

struct AnswerStaticModel: Decodable, Identifiable {
    var optionId: Int
    var selectivity: Double
    var id: Int {
        return optionId
    }
}

var questionStatisticSample: QuestionStatisticModel = QuestionStatisticModel(quizInfo: QuizInfoModel(quizId: 0, quizTitle: "퀴즈 테스트1", questions: [QuestionOnStatisticModel(title: "내가 제일 좋아하는 최고 흉기차는?", priorty: 1, duplicatedOption: true, options: [AnswerModel(id: 0, content: "아방가르도", order: 0, isCorrect: false), AnswerModel(id: 1, content: "투싼", order: 1, isCorrect: false), AnswerModel(id: 2, content: "GV70", order: 2, isCorrect: false), AnswerModel(id: 3, content: "쏘렌토", order: 3, isCorrect: true), AnswerModel(id: 4, content: "EV9", order: 4, isCorrect: false)])]), statistic: QuizStatisticModel(questionId: 0, options: [AnswerStaticModel(optionId: 0, selectivity: 1.0), AnswerStaticModel(optionId: 1, selectivity: 0.8), AnswerStaticModel(optionId: 2, selectivity: 0.6), AnswerStaticModel(optionId: 3, selectivity: 0.4), AnswerStaticModel(optionId: 4, selectivity: 0.2)]))
