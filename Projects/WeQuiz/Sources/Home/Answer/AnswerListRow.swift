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
    @ObservedObject var viewModel: AnswerListRowDataStore = AnswerListRowDataStore()
    @State var percentViewSize = CGSize(width: 0, height: 0)
    @State var alphabetCircleSize = CGSize(width: 0, height: 0)
    @State var contentTextSize = CGSize(width: 0, height: 0)
    @State var spacerSize = CGSize(width: 0, height: 0)
    @State var percentTextSize = CGSize(width: 0, height: 0)
        
    var body: some View {
        let answerNum = model.rank - 1
        var alphabetCircleTextColor = textColor(lhs: alphabetCircleSize.width, rhs: percentViewSize.width)
        var contentTextColor = textColor(lhs: alphabetCircleSize.width + contentTextSize.width, rhs: percentViewSize.width)
        var percentTextColor = textColor(lhs: alphabetCircleSize.width + contentTextSize.width + spacerSize.width + percentTextSize.width, rhs: percentViewSize.width)
        
        
        if listType == .back {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    AnswerPercentView(id: model.rank)
                        .frame(width: geometry.size.width * CGFloat(model.selectivity), height: geometry.size.height)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        percentViewSize = proxy.size
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
                                            spacerSize = proxy.size
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
    func textColor(lhs: CGFloat, rhs: CGFloat) -> Color {
        return lhs <= rhs ? Color.designSystem(.g9) : Color.designSystem(.g2)
    }
}
