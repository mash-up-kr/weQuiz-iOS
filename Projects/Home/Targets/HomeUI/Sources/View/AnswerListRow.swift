//
//  QuestionDetailRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/06/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import QuizUI

struct AnswerListRow: View {
    
    var index: Int
    var contents: String
    var percent: CGFloat
    
    var body: some View {
        
        HStack {
            AlphabetCircleView(answerNumber: index)
            Text(contents)
                .font(.pretendard(.medium, size: ._16))
            Spacer()
        }
        .padding()
        .foregroundColor(.designSystem(.g2))
        .background(Color.clear)
        .cornerRadius(16)
    }
}

struct QuestionDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        AnswerListRow(index: 1, contents: questionsSamlple[0].questions.description, percent: 30)
    }
}
