//
//  AddAnswerButtonView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct AddAnswerButtonView: View {
    
    var answerNumber: Int = 2
    
    public init(answerNumber: Int) {
        self.answerNumber = answerNumber
    }
    
    var body: some View {
        HStack {
            Text(String(UnicodeScalar(answerNumber + 65)!))
                .font(.pretendard(.medium, size: ._16))
                .foregroundColor(
                    Color.designSystem(.g6)
                )
                .frame(width: 24, height: 24, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5]))
                        .foregroundColor(Color.designSystem(.g6))
                )
            

            Text("답변 추가")
                .frame(alignment: .leading)
                .font(.pretendard(.medium, size: ._16))
                .foregroundColor(
                    Color.designSystem(.g6)
                )
            
            Spacer()
        }
        .padding(.all, 16)
        .background(
            .clear
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [7]))
                .foregroundColor(Color.designSystem(.g6))
        )
    }
}

struct AddAnswerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddAnswerButtonView(answerNumber: 2)
    }
}
