//
//  AnwerList.swift
//  WeQuiz
//
//  Created by 최원석 on 2023/08/05.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct AnswerList: View {

    var question: QuestionViewModel
    var questionsCount: Int
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("\(question.rank). \(question.questionTitle)")
                        .font(.pretendard(.medium, size: ._16))
                        .foregroundColor(.designSystem(.g2))
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 20)
                
                ForEach(question.options) { answer in
                    ZStack(alignment: .leading) {
                        AnswerListRow(model: answer)
                    }
                    .background(Color.designSystem(.g9))
                    .cornerRadius(16)
                }
                
                HStack {
                    Spacer()
                    Text("\(question.rank)/\(questionsCount)")
                        .font(.pretendard(.medium, size: ._14))
                    Spacer()
                }
                .padding(.vertical, 24)
            }
            .padding(.horizontal, 16)
            .background(Color.designSystem(.g8))
            .cornerRadius(16)
        }
    }
}
