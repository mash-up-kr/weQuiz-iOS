//
//  Question.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

struct QuestionGroup {
    var title: String
    var description: String
    var questions: [Question]
    let id: UUID = UUID()
    var writingState: Bool
}

struct Question {
    var num: Int
    var title: String
    var content: [String]
    var id: UUID = UUID()
}

extension QuestionGroup: Decodable { }
extension QuestionGroup: Identifiable { }
extension QuestionGroup: Equatable { }

extension Question: Decodable { }
extension Question: Identifiable { }
extension Question: Equatable { }


var questionsSamlple: [QuestionGroup] = [
    QuestionGroup(title: "테스트 제목", description: "테스트 내용", questions: [Question(num: 1, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 2, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 3, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 4, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"])], writingState: true),
    QuestionGroup(title: "테스트 제목", description: "테스트 내용", questions: [Question(num: 1, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 2, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 3, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 4, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"])], writingState: true),
    QuestionGroup(title: "테스트 제목", description: "테스트 내용", questions: [Question(num: 1, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 2, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 3, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 4, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"])], writingState: true),
    QuestionGroup(title: "테스트 제목", description: "테스트 내용", questions: [Question(num: 1, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 2, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 3, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 4, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"])], writingState: true),
    QuestionGroup(title: "테스트 제목", description: "테스트 내용", questions: [Question(num: 1, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 2, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 3, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"]), Question(num: 4, title: "문제는 이것이다.", content: ["1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용","1에 대한 내용"])], writingState: true),
]
