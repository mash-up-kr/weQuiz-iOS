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
    @State private var userIdentifyFailToastModel: WQToast.Model?
    
    private let quizId: Int
    private let solveQuizModel: SolveQuizModel
    private let quizService: QuizService = .init(Networking())
    
    init(quizId: Int, solveQuizModel: SolveQuizModel) {
        self.quizId = quizId
        self.solveQuizModel = solveQuizModel
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
                WQButton(style: .single(
                    .init(
                        title: "완료",
                        isEnable: $isUserNameValid,
                        action: {
                            Task {
                                guard let solver = await solveQuizUsesrIndentify(userNameInput) else {
                                    showIdentifyFailToast()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        solveQuizNavigator.popToroot()
                                    }
                                    return
                                }
                                solveQuizNavigator.path.append(
                                    .solve(quizId, solveQuizModel, solver)
                                )
                            }
                        }
                    )
                ))
            }
        }
        .toast(model: $userIdentifyFailToastModel)
        .navigationBarBackButtonHidden()
    }
    
    private func title() -> some View {
        HStack {
            Text("친구가 알 수 있게\n본인의 이름을 적어주세요")
                .font(.pretendard(.bold, size: ._24))
                .foregroundColor(.white)
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
                        input <= 8
                    })
            ))
        }
    }
}

extension SolveQuizUserNameInputView {
    private func showIdentifyFailToast() {
        userIdentifyFailToastModel = .init(status: .warning, text: "일시적 오류입니다.\n잠시 후 다시 시도해주세요")
    }
    
    private func solveQuizUsesrIndentify(_ nickname: String) async -> SolveQuizUser? {
        if let _ = AuthManager.shared.token {
            return .user
        } else {
            if let temporaryToken = await quizService.getTemporaryToken(nickname: nickname)?.token {
                return .nonUser(temporaryToken)
            }
        }
        return nil
    }
}
