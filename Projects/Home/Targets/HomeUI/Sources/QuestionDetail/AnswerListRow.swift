//
//  QuestionDetailRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/06/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import HomeKit

struct AnswerListRow: View {
    
    var model: AnswerViewModel
    
    var body: some View {
        
        HStack {
            AlphabetCircleView(answerNumber: model.rank)
            Text(model.content)
                .font(.pretendard(.medium, size: ._16))
            Spacer()
        }
        .padding()
        .foregroundColor(.designSystem(.g2))
        .background(Color.clear)
        .cornerRadius(16)
    }
}
