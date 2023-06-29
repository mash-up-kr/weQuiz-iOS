//
//  InputAnswerView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import QuizKit

public struct InputAnswerView: View {
    
    
    var answerNumber: Int = 0
    @Binding var answer: String
    @State var isSelected: Bool = false
    
    public init(answerNumber: Int, answer: Binding<String>) {
        self.answerNumber = answerNumber
        self._answer = answer
    }
    
    public var body: some View {
        HStack {
            ZStack {
                Image(Icon.Checkmark.falseFill24)
                    .hidden(!isSelected)
                
                AlphabetCircleView(answerNumber: answerNumber)
                    .hidden(isSelected)
            }
            .onTapGesture {
                isSelected.toggle()
            }
            
            Spacer()

            TextField("", text: $answer, prompt: Text("답변 입력")
                    .foregroundColor(
                        Color.designSystem(.g4)
                    )
                )
                .font(.pretendard(.medium, size: ._16))
                .foregroundColor(
                    isSelected ? Color.designSystem(.g2) : Color.designSystem(.g4)
                )
        }
        .padding(.all, 16)
        .background(
            isSelected ? Color.designSystem(.p1) : Color.designSystem(.g7)
        )
        .cornerRadius(16)
        
    }
}

struct InputAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        InputAnswerView(answerNumber: 0, answer: .constant(""))
    }
}
