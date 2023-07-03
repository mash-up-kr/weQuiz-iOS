//
//  QuestionDetailRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/06/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct AnswerListRow: View {
    
    var index: Int
    var contents: String
    
    var body: some View {
        HStack {
            ZStack {
                Image(Icon.Checkmark.falseFill24)
                
//                AlphabetCircleView(answerNumber: index)
//                    .hidden(contents.isCorrect.wrappedValue)
            }
            Text(contents)
                .font(.pretendard(.medium, size: ._16))
            Spacer()
        }
        .padding()
        .foregroundColor(.designSystem(.g2))
        .background(Color.designSystem(.g9))
        .cornerRadius(16)
    }
}

//struct QuestionDetailRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AnswerListRow(contents: questionsSamlple[0].questions.description)
//    }
//}
