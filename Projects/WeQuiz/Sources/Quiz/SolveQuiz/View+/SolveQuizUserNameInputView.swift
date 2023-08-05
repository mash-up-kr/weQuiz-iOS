//
//  SolveQuizUserNameInputView.swift
//  QuizUI
//
//  Created by AhnSangHoon on 2023/07/04.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct SolveQuizUserNameInputView: View {
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    @State private var userNameInput: String = ""
    @State private var isUserNameValid: Bool = false

    private let quizId: Int
    
    init(quizId: Int) {
        self.quizId = quizId
    }
    
    public var body: some View {
        VStack {
            WQTopBar(style: .navigation(
                .init(
                    title: "",
                    action: {
                        solveQuizNavigator.back()
                    }
                )
            ))
            VStack(spacing: .zero) {
                title()
                Spacer()
                    .frame(height: 42)
                nameInput()
                Spacer()
            }
            .padding(.horizontal, 20)
            VStack(spacing: 16) {
                tooltip()
                WQButton(style: .single(
                    .init(
                        title: "완료",
                        action: {
                            solveQuizNavigator.path.append(.solve(quizId))
                        }
                    )
                ))
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func title() -> some View {
        HStack {
            Text("친구가 알 수 있게\n본인의 이름을 적어주세요")
                .font(.pretendard(.bold, size: ._24))
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.top, 76)
    }
    
    private func nameInput() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 4) {
                Text("이름")
                    .font(.pretendard(.medium, size: ._12))
                    .foregroundColor(.designSystem(.g2))
                Text("(필수)")
                    .font(.pretendard(.regular, size: ._12))
                    .foregroundColor(.designSystem(.alert))
            }
            WQInputField(style: .limitCharacter(
                .init(
                    input: $userNameInput,
                    isValid: $isUserNameValid,
                    placeholder: "이름 입력",
                    limit: 8,
                    condition: { input in
                        input < 8
                    })
            ))
        }
    }
    
    private func tooltip() -> some View {
        Text("1분만에 가입해서 친구한테 문제내기 🗯️️")
            .font(.pretendard(.bold, size: ._16))
            .foregroundColor(.designSystem(.g3))
            .padding(.horizontal, 21)
            .padding(.vertical, 7)
            .background(Color.designSystem(.g8))
            .cornerRadius(19)
            .onTapGesture {
                print("툴팁 터치")
            }
    }
}
