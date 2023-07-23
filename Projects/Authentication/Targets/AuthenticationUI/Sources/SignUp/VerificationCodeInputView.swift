//
//  VerificationCodeInputView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import AuthenticationKit
import DesignSystemKit

public struct VerificationCodeInputView: View {
    @EnvironmentObject var authManager: AuthManager
    @ObservedObject var presenter: VerificationCodeInputPresenter
    
    @State private var input: String = ""
    @State private var isValid: Bool = false
    @State private var verificationCodeInvalidToastModel: WQToast.Model?
    
    private var interactor: VerificationCodeInputRequestingLogic?
    private let phoneNumber: String
    
    public init(
        interactor: VerificationCodeInputRequestingLogic,
        presenter: VerificationCodeInputPresenter,
        phoneNumber: String
    ) {
        self.phoneNumber = phoneNumber
        self.interactor = interactor
        self.presenter = presenter
        
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
            interactor?.reqeust(VerificationCodeInputModel.Request.OnRequestVerifyCode(
                remainTime: presenter.viewModel.remainTime,
                isValid: isValid,
                code: input
            ))
        }
        .onChange(of: presenter.viewModel.toastModel, perform: { model in
            switch model {
            case .invalidCode:
                verificationCodeInvalidToastModel = .init(status: .warning, text: "인증번호가 올바르지 않아요")
            case .expiredCode:
                verificationCodeInvalidToastModel = .init(status: .warning, text: "인증번호가 만료됐어요. 다시 시도해 주세요")
            case .timeout:
                verificationCodeInvalidToastModel = .init(status: .warning, text: "인증번호 시간이 만료됐어요\n재전송을 눌러 다시 시도해 주세요")
            case .unknown:
                verificationCodeInvalidToastModel = .init(status: .warning, text: "잠시 후 다시 시도해 주세요")
            }
        })
        .toast(model: $verificationCodeInvalidToastModel)
    }
}

// MARK: - Private

extension VerificationCodeInputView {
    private func viewDidLoad() {
        self.interactor?.reqeust(VerificationCodeInputModel.Request.OnLoad())
    }
}

struct VerificationCodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = VerificationCodeInputPresenter(navigator: .shared)
        let interactor = VerificationCodeInputInteractor(
            presenter: presenter,
            authManager: .shared
        )
        return VerificationCodeInputView(
            interactor: interactor,
            presenter: presenter,
            phoneNumber: "12341234"
        )
    }
}
