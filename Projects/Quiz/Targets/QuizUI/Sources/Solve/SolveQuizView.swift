//
//  SolveQuizView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/10.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

public struct SolveQuizView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            WQTopBar(style: .navigationWithButtons(
                .init(title: "",
                      bttons: [
                        .init(icon: Icon.Siren.mono, action: {
                    print("신고하기 버튼 클릭")
                })
                ])
            ))
            
            tooltip(1, 5)
            
            Spacer()
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
}

struct SolveQuizView_Previews: PreviewProvider {
    static var previews: some View {
        SolveQuizView()
    }
}
