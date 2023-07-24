//
//  UserInformationInputView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import AuthenticationKit
import DesignSystemKit

public struct UserInformationInputView: View {
    @ObservedObject private var presenter: UserInformationInputPresenter
    
    @State private var nickname: String = ""
    @State private var isNicknameValid: Bool = false
    @State private var introduction: String = ""
    @State private var isIntroductionValid: Bool = false
    @State private var userInformationInputToastModel: WQToast.Model?
    
    private let interactor: UserInformationInputRequestingLogic?
    private let phoneNumber: String
    
    public init(
        interactor: UserInformationInputRequestingLogic,
        presenter: UserInformationInputPresenter,
        phoneNumber: String
    ) {
        self.presenter = presenter
        self.interactor = interactor
        self.phoneNumber = phoneNumber
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            WQTopBar(style: .navigation(
                .init(
                    title: "",
                    action: {
                        interactor?.request(UserInformationInputModel.Request.OnTouchNavigationBack())
                    }
                )
            ))
            VStack(alignment: .leading, spacing: .zero) {
                Text("{서비스명}에서 사용 할\n닉네임을 입력해 주세요")
                    .font(.pretendard(.bold, size: ._24))
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 36)
                Input(
                    nickname: $nickname,
                    isNicknameValid: $isNicknameValid,
                    introduction: $introduction,
                    isIntroductionValid: $isIntroductionValid
                )
            }
            .padding(
                .init(
                    top: 20,
                    leading: 20,
                    bottom: .zero,
                    trailing: 20
                )
            )
            Spacer()
            WQButton(
                style: .fullRadiusSingle(
                    .init(
                        title: "다음",
                        isEnable: $isNicknameValid,
                        action: {
                            interactor?.request(UserInformationInputModel.Request.OnRequestSignUp(
                                phone: phoneNumber,
                                nickname: nickname,
                                description: introduction
                            ))
                        }
                    )
                )
            )
        }
        .onChange(of: presenter.viewModel.toastModel) { model in
            switch model {
            case .signUpFailed:
                userInformationInputToastModel = .init(status: .warning, text: "회원가입에 실패하였습니다. 개발자에게 문의해주세요")
            case .unknown:
                userInformationInputToastModel = .init(status: .warning, text: "잠시 후 다시 시도해 주세요")
            }
        }
        .toast(model: $userInformationInputToastModel)
    }
    
    private struct Input: View {
        @Binding private var nickname: String
        @Binding private var isNicknameValid: Bool
        @Binding private var introduction: String
        @Binding private var isIntroductionValid: Bool
        
        init(
            nickname: Binding<String>,
            isNicknameValid: Binding<Bool>,
            introduction: Binding<String>,
            isIntroductionValid: Binding<Bool>
        ) {
            self._nickname = nickname
            self._isNicknameValid = isNicknameValid
            self._introduction = introduction
            self._isIntroductionValid = isIntroductionValid
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 4) {
                        Text("닉네임")
                            .font(.pretendard(.medium, size: ._12))
                            .foregroundColor(.designSystem(.g2))
                        Text("(필수)")
                            .font(.pretendard(.regular, size: ._12))
                            .foregroundColor(.designSystem(.alert))
                    }
                    WQInputField(style: .limitCharacter(
                        .init(
                            input: $nickname,
                            isValid: $isNicknameValid,
                            placeholder: "닉네임 입력",
                            limit: 8,
                            condition: { input in
                                input < 8
                            })
                    ))
                }
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 4) {
                        Text("자기소개")
                            .font(.pretendard(.medium, size: ._12))
                            .foregroundColor(.designSystem(.g2))
                        Text("(필수)")
                            .font(.pretendard(.regular, size: ._12))
                            .foregroundColor(.designSystem(.g4))
                    }
                    WQInputField(style: .limitCharacter(
                        .init(
                            input: $introduction,
                            isValid: $isIntroductionValid,
                            placeholder: "자기소개 입력",
                            limit: 30,
                            condition: { input in
                                input < 30
                            })
                    ))
                }
            }
        }
    }
}

struct UserInformationInputView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = UserInformationInputPresenter(navigator: .shared)
        let interactor = UserInformationInputInteractor(
            presenter: presenter,
            authManager: .shared
        )
        UserInformationInputView(
            interactor: interactor,
            presenter: presenter,
            phoneNumber: "12341234"
        )
    }
}
