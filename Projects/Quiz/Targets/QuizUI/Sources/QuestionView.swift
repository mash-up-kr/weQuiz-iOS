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
    @State var answerModel = AnswerModel.init(allAnswers: ["", ""])
    @State var expandedHeight: CGFloat = 230
    
    
    var onRemove: ((UUID) -> ())?
    
    public init(model: Binding<QuestionModel>, onRemove: ((UUID) -> ())?) {
        self._model = model
        self.onRemove = onRemove
    }
    
    public var body: some View {
        
        ZStack(alignment: .topTrailing) {
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
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.3)) {
                            isExpand.toggle()
                        }
                    }
                
                    
                VStack {
                    ForEach(0..<answerModel.allAnswers.count, id: \.self) { index in
                        InputAnswerView(answerNumber: index, answer: $answerModel.allAnswers[index])
                            .frame(height: 56)
                        
                    }
                
                    AddAnswerView(answerNumber: answerModel.allAnswers.count)
                        .frame(height: 70)
                        .onTapGesture {
                            if self.answerModel.allAnswers.count < 10 {
                                self.answerModel.allAnswers.append("")
                                self.expandedHeight += 65
                            }
                        }

                }
                .hidden(!isExpand)
                .modifier(AnimatingCellHeight(height: isExpand ? expandedHeight : 0))
                .padding(.horizontal, 20)
                
                Spacer()
                
            }
            .background(
                Color.designSystem(.g8)
            )
            .cornerRadius(16)
            
            if isExpand == true {
                Image(Icon.Close.fillWhite)
                    .onTapGesture {
                        onRemove?(model.id)
                    }
            }
            
        }
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

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(model: .constant(.init(title: "title"))) { idx in
            //
        }
    }
}

public extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
