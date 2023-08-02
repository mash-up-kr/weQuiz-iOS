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
    
    var listType: AnswerListType
    var model: AnswerViewModel
    
    var body: some View {
        
        HStack {
            AlphabetCircleView(answerNumber: model.rank)
            Text(model.content)
                .font(.pretendard(.medium, size: ._16))
            Spacer()
            if listType == .back {
                Text("\(Int(model.selectivity * 100))%")
            }
        }
        .padding()
        .foregroundColor(.designSystem(.g2))
        .background(Color.clear)
        .cornerRadius(16)
    }
}
