//
//  QuestionRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct QuestionGroupRow: View {
    @Binding var questionGroup: QuestionGroup
    
    var body: some View {
        HStack {
            self.questionsDescription
            Spacer()
            self.writingStateView
        }
        .frame(height: 58)
        .background(Color.designSystem(.g8))
        .cornerRadius(16)
    }
}

extension QuestionGroupRow {
    private var questionsDescription: some View {
        Text(questionGroup.title)
            .foregroundColor(.designSystem(.g1))
            .font(.pretendard(.medium, size: ._16))
            .padding(.leading, 16)
    }
    
    @ViewBuilder
    private var writingStateView: some View {
        let writingState = questionGroup.writingState
        
        if writingState {
            ZStack {
                Text("작성 중")
                    .padding(.all, 4)
                    .font(.pretendard(.medium, size: ._12))
                    .foregroundColor(.designSystem(.s1))
            }
            .background(.black)
            .cornerRadius(4)
            .padding(.trailing, 16)
            .padding(.leading, 8)
        } else {
            EmptyView()
        }
    }
}
