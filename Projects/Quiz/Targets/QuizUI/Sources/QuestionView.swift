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
    
    @Binding var model: QuestionModel
    
    @State var questionTitle: String = ""
    @State var isExpand = false
    @State var expandedHeight: CGFloat = 250
    @State var isMultipleSelection = false
    
    
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
                    ForEach(0..<$model.answers.count, id: \.self) { index in
                        InputAnswerView(index: index,
                                        answer: $model.answers[index],
                                        isCorrectAnswer: { isCorrect in
                            if isCorrect == true && $isMultipleSelection.wrappedValue == false {
                                deselectAllList()
                                model.answers[index].isCorrect = true
                            }
                        })
                        .frame(height: 56)
                        
                    }
                    
                    AddAnswerView(answerNumber: $model.answers.count)
                        .frame(height: 70)
                        .onTapGesture {
                            addAnswer()
                        }
                    
                    MultipleSelectionView(isSelected: $isMultipleSelection)
                        .onChange(of: isMultipleSelection) { newValue in
                            if newValue == false {
                                deselectAllList()
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
    
    private func addAnswer() {
        if self.model.answers.count >= 10 { return }
        self.model.answers.append(AnswerModel.init())
        self.expandedHeight += 65
    }
    
    private func deselectAllList() {
        for i in 0..<$model.answers.count {
            model.answers[i].isCorrect = false
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
