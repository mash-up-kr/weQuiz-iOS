//
//  SolveQuizView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/10.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import QuizKit

public struct SolveQuizView: View {
    
    @Binding private var model: SolveQuestionModel
    
    public init(model: Binding<SolveQuestionModel>) {
        self._model = model
    }
    
    //TODO: - nowCount, allCount 주입 받아서 수정해야함
    @State var nowCount: Int = 1
    var allCount: Int = 10
    
    public var body: some View {
        
        ZStack {
            VStack {
                WQTopBar(style: .navigationWithButtons(
                    .init(title: "",
                          bttons: [
                            .init(icon: Icon.Siren.mono, action: {
                        print("신고하기 버튼 클릭")
                    })
                    ])
                ))
                
                WQGradientProgressBar(
                    standard: allCount,
                    current: $nowCount
                )
                
                tooltip(nowCount, allCount)
                
                
                Spacer()
            }
            .background(Color.designSystem(.g9))
            
            VStack(alignment: .center) {
                
                Text("\(nowCount)")
                    .font(.pretendard(.bold, size: ._20))
                    .foregroundColor(Color.designSystem(.g1))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 26)
                Text(model.title)
                    .font(.pretendard(.medium, size: ._24))
                    .foregroundColor(Color.designSystem(.g1))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 34)
                Text("답 \(model.answerCount)개")
                    .font(.pretendard(.bold, size: ._16))
                    .foregroundStyle(
                        DesignSystemKit.Gradient.gradientS1.linearGradient
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .frame(height: 24)
                
                ForEach(0..<$model.answers.count, id: \.self) { index in
                    answerView(model.answers[index])
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func tooltip(_ nowCount: Int, _ allCount: Int) -> some View {
        Text("\(nowCount)문제 중 \(allCount)번째 문제")
            .font(.pretendard(.bold, size: ._14))
            .foregroundColor(.designSystem(.g4))
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color.designSystem(.g8))
            .cornerRadius(16)
            .frame(height: 32)
    }
    
    private func answerView(_ model: SolveAnswerModel) -> some View {
        Text(model.answer)
            .font(.pretendard(.bold, size: ._18))
            .foregroundColor(Color.designSystem(.g2))
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 58)
            .background(Color.designSystem(.g8))
            .cornerRadius(16)
    }
}

struct SolveQuizView_Previews: PreviewProvider {
    static var previews: some View {
        SolveQuizView(model: .constant(SolveQuestionModel(title: "내가 좋아하는 색은?", answerCount: 1, answers: [SolveAnswerModel(answer: "빨간색", order: 0, isCorrect: false), SolveAnswerModel(answer: "노란색", order: 1, isCorrect: false), SolveAnswerModel(answer: "초록색", order: 2, isCorrect: false)])))
    }
}
