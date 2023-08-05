//
//  AnswearList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/15.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

enum AnswerListType {
    case front
    case back
}

struct AnswerListContainer: View {
    
    var question: QuestionViewModel
    var questionsCount: Int
    var questionId: Int
    
    var body: some View {
        ZStack {
            AnswerList(question: question, questionsCount: questionsCount)
        }
    }
}
