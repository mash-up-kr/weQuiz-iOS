//
//  QuestionView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/17.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import QuizKit

public struct QuestionView: View {
    
    @State var questionTitle: String = ""
    @State var isExpand = false
    
    @Binding var model: QuestionModel
    
    public init(model: Binding<QuestionModel>) {
        self._model = model
    }
    
    public var body: some View {
        VStack {
            TextField("", text: $questionTitle, prompt: Text("문제 입력")
                    .font(.pretendard(.medium, size: ._18))
                    .foregroundColor(.designSystem(.g4))
                    )
                .font(.pretendard(.medium, size: ._18))
                .frame(minHeight: 26)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.designSystem(.g4))
                .padding([.top, .horizontal], 20)
                .padding(.bottom, 16)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.3)) {
                        isExpand.toggle()
                    }
                }
                
            if isExpand == true {
                VStack {
                    ForEach(0..<2) { index in
                        InputAnswerView(answerNumber: index)
                    }
                    
                    AddAnswerView()
                    
                }
                .padding(.horizontal, 20)
            }
            
            Spacer()
        }
        .modifier(AnimatingCellHeight(height: isExpand ? 300 : 68))
        
        .background(
            Color.designSystem(.g8)
        )
        .cornerRadius(16)
    }
}

struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0

    var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }

    func body(content: Content) -> some View {
        content.frame(height: height)
    }
}

//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView(title: "문제 입력")
//    }
//}
