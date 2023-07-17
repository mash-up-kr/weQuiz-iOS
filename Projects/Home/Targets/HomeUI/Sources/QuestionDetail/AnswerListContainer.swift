//
//  AnswearList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/15.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit


enum AnswerListType {
    case front
    case back
}

struct AnswerListContainer: View {
    
    var question: Question
    var questionsCount: Int
    
    @State var backDegree = 180.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
    
    let durationAndDelay: CGFloat = 0.3
    
    var body: some View {
        ZStack {
            AnswerList(listType: .front, question: question, questionsCount: questionsCount, degree: $frontDegree)
                .opacity(isFlipped ? 0 : 1)
            AnswerList(listType: .back, question: question, questionsCount: questionsCount, degree: $backDegree)
                .opacity(isFlipped ? 1 : 0)
        }
        .onTapGesture {
                flipCard()
            }
        }
}

extension AnswerListContainer {
    func flipCard() {
        isFlipped.toggle()
        
        withAnimation(.linear(duration: durationAndDelay)) {
            frontDegree += 180
        }
        
        withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
            backDegree += 180
        }
    }
}

struct AnswerList: View {
    
    var listType: AnswerListType
    var question: Question
    var questionsCount: Int
    @Binding var degree: Double
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                HStack {
                    Text("\(question.num). \(question.title)")
                        .font(.pretendard(.medium, size: ._18))
                        .foregroundColor(.designSystem(.g2))
                }
                ForEach(question.content.indices) { index in
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            if listType == .back {
                                AnswerPercentView(index: index)
                                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                            }
                            AnswerListRow(index: index, contents: question.content[index], percent: 10)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                        .background(Color.designSystem(.g9))
                        .cornerRadius(16)
                    }
                    .frame(height: 56)
                }
                HStack {
                    Text("\(question.num)/\(questionsCount)")
                    Spacer()
                    Button(action: {
                        print("버튼을 눌러보세요")
                    }) {
                        HStack {
                            Text("눌러서 결과보기")
                                .font(.pretendard(.medium, size: ._14))
                                .foregroundColor(.designSystem(.g2))
                            Image(Icon.Chevron.rightMedium)
                        }
                    }
                    .disabled(true)
                }
            }
            .padding()
            .background(Color.designSystem(.g8))
            .cornerRadius(16)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        }
    }
}
