//
//  QuestionView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/17.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct QuestionView: View {
    
    @Binding private var model: MakeQuestionModel
    @State private var expandedHeight: CGFloat = 326
    
    private var onRemove: ((UUID) -> ())?
    private var onExpand: ((UUID) -> ())?
    private var isChanged: (() -> ())?
    
    public init(model: Binding<MakeQuestionModel>, onRemove: ((UUID) -> ())?, onExpand: ((UUID) -> ())?, isChanged: (() -> ())?) {
        self._model = model
        self.onRemove = onRemove
        self.onExpand = onExpand
        self.isChanged = isChanged
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                questionTextField()
                
                if model.isExpand {
                    VStack {
                        answerInputs()
                        
                        if self.model.answers.count < 5 {
                            AddAnswerButtonView(answerNumber: $model.answers.count)
                                .frame(height: 56)
                                .onTapGesture {
                                    addAnswer()
                                }
                        }

                        MultipleSelectionView(isSelected: $model.duplicatedOption)
                            .onChange(of: model.duplicatedOption) { newValue in
                                if newValue == false {
                                    deselectAllList()
                                }
                            }

                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
            }
            .onChange(of: model) { _ in
                isChanged?()
            }
            .frame(height: model.isExpand ? expandedHeight : 66)
            .background(
                Color.designSystem(.g8)
            )
            .cornerRadius(16)
            .padding(.horizontal, 20)
            .padding(.top, 4)
            
            Image(Icon.Close.fillWhite)
                .onTapGesture {
                    onRemove?(model.id)
                }
                .padding(.trailing, 14)
                .hidden(!model.isExpand)
        }
        
    }
    
    private func questionTextField() -> some View {
        TextField("", text: $model.title, prompt: Text("문제 입력")
                .font(.pretendard(.medium, size: ._18))
                .foregroundColor(.designSystem(.g4))
            )
            .font(.pretendard(.medium, size: ._18))
            .frame(height: 66)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.designSystem(.g4))
            .padding(.horizontal, 20)
            .onTapGesture {
                withAnimation(.linear(duration: 0.3)) {
                    model.isExpand.toggle()
                    if model.isExpand == true {
                        onExpand?(model.id)
                    }
                }
            }
    }
    
    private func answerInputs() -> some View {
        ForEach(0..<$model.answers.count, id: \.self) { index in
            AnswerView(index: index,
                            answer: $model.answers[index],
                            isCorrectAnswer: { isCorrect in
                if isCorrect == true && model.duplicatedOption == false {
                    deselectAllList()
                    model.answers[index].isCorrect = true
                }
            })
            .padding(.bottom, 10)
        }
    }
    
    private func addAnswer() {
        if self.model.answers.count >= 5 { return }
        if self.model.answers.count < 4 {
            self.expandedHeight += 72
        }
        
        self.model.answers.append(MakeAnswerModel.init())
    }
    
    private func deselectAllList() {
        for i in 0..<$model.answers.count {
            model.answers[i].isCorrect = false
        }
    }
}

//struct Question_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView(model: .constant(.init(title: "title"))) { idx in
//            //
//        }
//    }
//}
