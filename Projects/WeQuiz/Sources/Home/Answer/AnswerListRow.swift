//
//  QuestionDetailRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/06/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct AnswerListRow: View {
    
    var listType: AnswerListType
    var model: AnswerViewModel
    @State var percentViewSize: CGSize = CGSize(width: 0, height: 0)
    @State var alphabetCircleSize: CGSize = CGSize(width: 0, height: 0)
    @State var contentTextSize: CGSize = CGSize(width: 0, height: 0)
    @State var spacerSize: CGSize = CGSize(width: 0, height: 0)
    @State var percentTextSize: CGSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        let answerNum = model.rank - 1
        let alphabetCircleTextColor = textColor(lhs: alphabetCircleSize.width, rhs: percentTextSize.width)
        let contentTextColor = textColor(lhs: (alphabetCircleSize.width + contentTextSize.width), rhs: percentTextSize.width)
        let percentTextColor = textColor(lhs: (alphabetCircleSize.width + contentTextSize.width + spacerSize.width + percentTextSize.width), rhs: percentTextSize.width)
        
        if listType == .back {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    AnswerPercentView(id: model.rank)
                        .frame(width: geometry.size.width * CGFloat(model.selectivity), height: geometry.size.height)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        self.percentViewSize = proxy.size
                                    }
                            }
                        )
                    
                    HStack {
                        AlphabetCircleView(answerNumber: answerNum, textColor: alphabetCircleTextColor)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            alphabetCircleSize = proxy.size
                                        }
                                }
                            )
                        
                        Text(model.content)
                            .font(.pretendard(.medium, size: ._16))
                            .foregroundColor(contentTextColor)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            contentTextSize = proxy.size
                                        }
                                }
                            )
                        
                        Spacer()
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            percentTextSize = proxy.size
                                        }
                                }
                            )
                        
                        Text("\(Int(model.selectivity * 100))%")
                            .font(.pretendard(.medium, size: ._16))
                            .foregroundColor(percentTextColor)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            percentTextSize = proxy.size
                                        }
                                }
                            )
                    }
                    .padding()
                    .foregroundColor(.designSystem(.g2))
                    .background(Color.clear)
                    .cornerRadius(16)
                }
            }
        } else {
            HStack {
                AlphabetCircleView(answerNumber: answerNum, textColor: Color.designSystem(.g2))
                Text(model.content)
                    .font(.pretendard(.medium, size: ._16))
                Spacer()
            }
            .padding()
            .foregroundColor(.designSystem(.g2))
            .background(Color.clear)
            .cornerRadius(16)
        }
    }
}

extension AnswerListRow {
    func textColor(lhs: Double, rhs: Double) -> Color {
        return lhs <= rhs ? Color.designSystem(.g9) : Color.designSystem(.g2)
    }
}
