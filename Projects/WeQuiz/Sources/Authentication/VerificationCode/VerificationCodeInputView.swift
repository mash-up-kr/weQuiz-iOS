//
//  VerificationCodeInputView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct VerificationCodeInputView: View {
    @ObservedObject var presenter: VerificationCodeInputPresenter
    
    @State private var input: String = ""
    @State private var isValid: Bool = false
    @State private var verificationCodeToastModel: WQToast.Model?
    
    private var interactor: VerificationCodeInputRequestingLogic?
    private let phoneNumber: String
    private let signType: AuthenticationScreen.SignType

    public init(
        interactor: VerificationCodeInputRequestingLogic,
        presenter: VerificationCodeInputPresenter,
        phoneNumber: String,
        _ signType: AuthenticationScreen.SignType = .signIn
    ) {
        self.phoneNumber = phoneNumber
        self.interactor = interactor
        self.presenter = presenter
        self.signType = signType
        self.viewDidLoad()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            WQTopBar(style: .navigation(
                .init(
                    title: "",
                    action: {
                        interactor?.reqeust(VerificationCodeInputModel.Request.OnTouchNavigationBack())
                    })
            ))
            VStack(alignment: .leading, spacing: .zero) {
                Text("휴대폰 인증번호를\n입력해 주세요")
                    .font(.pretendard(.bold, size: ._24))
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 36)
                VStack(alignment: .leading, spacing: 12) {
                    Text("인증번호")
                        .font(.pretendard(.medium, size: ._12))
                        .foregroundColor(.designSystem(.g2))
                    WQInputField(style: .verificationCode(
                        .init(
                            input: $input,
                            isValid: $isValid,
                            timeLimit: $presenter.viewModel.remainTime,
                            resendHandler: {
                                interactor?.reqeust(
                                    VerificationCodeInputModel.Request.OnTouchReSend(
                                        phoneNumber: phoneNumber
                                    )
                                )
                            }
                        )
                    ))
                }
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
        }
        .onChange(of: isValid) { isValid in
            Task {
                await interactor?.reqeust(VerificationCodeInputModel.Request.OnRequestVerifyCode(
                    type: signType,
                    phoneNumber: phoneNumber,
                    remainTime: presenter.viewModel.remainTime,
                    isValid: isValid,
                    code: input
                ))
            }
        }
        .onChange(of: presenter.viewModel.toastModel, perform: { model in
            switch model {
            case .invalidCode:
                verificationCodeToastModel = .init(status: .warning, text: "인증번호가 올바르지 않아요")
            case .expiredCode:
                verificationCodeToastModel = .init(status: .warning, text: "인증번호가 만료됐어요. 다시 시도해 주세요")
            case .timeout:
                verificationCodeToastModel = .init(status: .warning, text: "인증번호 시간이 만료됐어요\n재전송을 눌러 다시 시도해 주세요")
            case .resendCode:
                verificationCodeToastModel = .init(status: .success, text: "인증번호를 재전송했어요")
            case .unknown:
                verificationCodeToastModel = .init(status: .warning, text: "잠시 후 다시 시도해 주세요")
            }
        })
        .toast(model: $verificationCodeToastModel)
        .modal(
            .init(message: "가입되지 않은 휴대폰 번호에요\n회원가입을 도와드릴까요?", doubleButtonStyleModel: .init(
                titles: ("아니오", "회원가입"),
                leftAction: {
                    input = ""
                    isValid = false
                    interactor?.reqeust(VerificationCodeInputModel.Request.OnLoad())
                    presenter.viewModel.modalModel.isPresented = false
                },
                rightAction: {
                    interactor?.reqeust(
                        VerificationCodeInputModel.Request.OnTouchSignUp(
                            type: signType,
                            phoneNumber: phoneNumber
                        )
                    )
                    input = ""
                    isValid = false
                    interactor?.reqeust(VerificationCodeInputModel.Request.OnLoad())
                    presenter.viewModel.modalModel.isPresented = false
                }
            )),
            isPresented: $presenter.viewModel.modalModel.isPresented
        )
    }
}

// MARK: - Private

extension VerificationCodeInputView {
    private func viewDidLoad() {
        interactor?.reqeust(VerificationCodeInputModel.Request.OnLoad())
    }
}
