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
    @State private var expandedHeight: CGFloat = 250
    
    private var onRemove: ((UUID) -> ())?
    private var onExpand: ((UUID) -> ())?
    
    public init(model: Binding<MakeQuestionModel>, onRemove: ((UUID) -> ())?, onExpand: ((UUID) -> ())?) {
        self._model = model
        self.onRemove = onRemove
        self.onExpand = onExpand
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                questionTextField()
                VStack {
                    answerInputs()
                    AddAnswerButtonView(answerNumber: $model.answers.count)
                        .frame(height: 72)
                        .onTapGesture {
                            addAnswer()
                        }
                    
                    MultipleSelectionView(isSelected: $model.duplicatedOption)
                        .onChange(of: model.duplicatedOption) { newValue in
                            if newValue == false {
                                deselectAllList()
                            }
                        }
                    
                }
                .hidden(!model.isExpand)
                .modifier(AnimatingCellHeight(height: model.isExpand ? expandedHeight : 0))
                .padding(.horizontal, 20)
                
                Spacer()
                
            }
            .background(
                Color.designSystem(.g8)
            )
            .cornerRadius(16)
            
            if model.isExpand == true {
                Image(Icon.Close.fillWhite)
                    .onTapGesture {
                        onRemove?(model.id)
                    }
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .padding([.top, .bottom], 8)
    }
    
    private func questionTextField() -> some View {
        TextField("", text: $model.title, prompt: Text("문제 입력")
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
        }
    }
    
    private func addAnswer() {
        if self.model.answers.count >= 5 { return }
        self.model.answers.append(MakeAnswerModel.init())
        self.expandedHeight += 65
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
