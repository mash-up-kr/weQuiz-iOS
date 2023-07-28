//
//  QuestionStatisticModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

// 현재 서버에서 QuestionDetail이랑 Statistic이랑 분리를 해놓았는데 이것을 하나로 묶을 필요가 있다.
public struct QuestionDetailModel: Decodable {
    public var quizInfo: QuizInfoModel
    public var statistic: [QuestionStatisticModel]
    
    public init(quizInfo: QuizInfoModel, statistic: [QuestionStatisticModel]) {
        self.quizInfo = quizInfo
        self.statistic = statistic
    }
}

public struct QuizInfoModel: Decodable, Identifiable {
    public var quizId: Int
    public var quizTitle: String
    public var questions: [QuestionModel]
    public var id: Int {
        return quizId
    }
    
    public init(quizId: Int, quizTitle: String, questions: [QuestionModel]) {
        self.quizId = quizId
        self.quizTitle = quizTitle
        self.questions = questions
    }
}

public struct QuestionModel: Decodable, Identifiable {
    public var questionId: Int
    public var questionTitle: String
    public var options: [AnswerModel]
    public var id: Int {
        return questionId
    }
    
    public init(questionId: Int, questionTitle: String, options: [AnswerModel]) {
        self.questionId = questionId
        self.questionTitle = questionTitle
        self.options = options
    }
}

public struct AnswerModel: Decodable, Identifiable {
    public var optionId: Int
    public var content: String
    public var id: Int {
        return optionId
    }
    
    public init(optionId: Int, content: String, priority: Int) {
        self.optionId = optionId
        self.content = content
    }
}

public struct QuestionStatisticModel: Decodable, Identifiable {
    public var questionId: Int
    public var options: [AnswerStatisticModel]
    public var id: Int {
        return questionId
    }
    
    public init(questionId: Int, options: [AnswerStatisticModel]) {
        self.questionId = questionId
        self.options = options
    }
}

public struct AnswerStatisticModel: Decodable, Identifiable {
    public var optionId: Int
    public var selectivity: Double
    public var id: Int {
        return optionId
    }
    
    public init(optionId: Int, selectivity: Double) {
        self.optionId = optionId
        self.selectivity = selectivity
    }
}

//public var questionDetailSample: QuestionDetailModel = QuestionDetailModel(quizInfo: QuizInfoModel(quizId: 0, quizTitle: "첫번쨰 퀴즈입니다.", questions: [QuestionModel(questionId: 0, title: "흉기차 중에 내가 제일 최고로 좋아하는 흉기는?", priorty: 0, duplicatedOption: true, options: [AnswerModel(optionId: 0, content: "투싼", priority: 1), AnswerModel(optionId: 1, content: "GV70", priority: 2), AnswerModel(optionId: 2, content: "쏘렌토", priority: 3), AnswerModel(optionId: 3, content: "텔룰라이드", priority: 4), AnswerModel(optionId: 4, content: "아방가르도", priority: 5)])]), statistic: [QuestionStatisticModel(questionId: 0, options: [AnswerStatisticModel(optionId: 0, selectivity: 1.0), AnswerStatisticModel(optionId: 1, selectivity: 0.8), AnswerStatisticModel(optionId: 2, selectivity: 0.6), AnswerStatisticModel(optionId: 3, selectivity: 0.4), AnswerStatisticModel(optionId: 4, selectivity: 0.2)])])
