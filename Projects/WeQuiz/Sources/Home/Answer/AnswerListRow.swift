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
    
    var model: AnswerViewModel
    @State private var percentViewSize = CGSize(width: 0, height: 0)
    @State private var contentTextSize = CGSize(width: 0, height: 0)
    @State private var spacerSize = CGSize(width: 0, height: 0)
    @State private var percentTextSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        let answerNum = model.rank - 1
        var contentTextColor = textColor(lhs: contentTextSize.width, rhs: percentViewSize.width)
        var percentTextColor = textColor(lhs: contentTextSize.width + spacerSize.width + percentTextSize.width, rhs: percentViewSize.width)
        
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
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
                }
                
                HStack {
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
}

extension AnswerListRow {
    func textColor(lhs: CGFloat, rhs: CGFloat) -> Color {
        return lhs <= rhs ? Color.designSystem(.g9) : Color.designSystem(.g2)
    }
}
