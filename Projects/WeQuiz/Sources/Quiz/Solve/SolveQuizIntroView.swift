//
//  SolveQuizIntroView.swift
//  QuizUI
//
//  Created by AhnSangHoon on 2023/07/03.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct SolveQuizIntroView: View {
    
    public init() { }
    
    public var body: some View {
        VStack {
            VStack(spacing: .zero) {
                quizNumber(10)
                title("출제자")
                Spacer()
                name()
                Spacer()
                    .frame(height: 30)
                thumbnail()
                Spacer()
            }
            .padding(.horizontal, 20)
            WQButton(style: .single(
                .init(
                    title: "시험 응시하기",
                    action: {
                        print("버튼눌림~")
                    }
                )
            ))
        }
    }
    
    private func quizNumber(_ number: Int) -> some View {
        ZStack(alignment: .leading) {
            Color.clear
                .frame(height: 32)
            HStack {
                Text("제 \(number)회")
                    .font(.pretendard(.bold, size: ._14))
                    .foregroundColor(.designSystem(.g4))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.designSystem(.g6))
                    .cornerRadius(16)
            }
        }
        .padding(.top, 46)
    }
    
    private func title(_ examiner: String) -> some View {
        VStack(spacing: 10) {
            Text("나를 맞춰봐! 시험지")
                .font(.pretendard(.medium, size: ._20))
                .foregroundColor(.designSystem(.g4))
            VStack(spacing: .zero) {
                Text(examiner)
                    .font(.pretendard(.bold, size: ._34))
                    .foregroundColor(.designSystem(.g1))
                Text("영역")
                    .font(.pretendard(.bold, size: ._28))
                    .foregroundColor(.designSystem(.g4))
            }
        }
    }
    
    private func name() -> some View {
        Color.designSystem(.g3)
            .frame(height: 36)
    }
    
    private func thumbnail() -> some View {
        Color.designSystem(.g4)
    }
}

struct SolveQuizIntroView_Previews: PreviewProvider {
    static var previews: some View {
        SolveQuizIntroView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
        SolveQuizIntroView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
    }
}
