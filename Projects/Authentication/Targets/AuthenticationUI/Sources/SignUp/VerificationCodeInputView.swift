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
    @StateObject private var router: AuthenticationRouter
    @EnvironmentObject var authManager: AuthManager
    
    @State private var verificationCodeInput: String = ""
    @State private var isVerificationCodeValid: Bool = false
    @State private var verificationCodeTimeLimit: Int = 180
    @State private var verificationCodeInvalidToastModel: WQToast.Model?
    
    private let phoneNumber: String
    
    public init(router: AuthenticationRouter, phoneNumber: String) {
        self._router = StateObject(wrappedValue: router)
        self.phoneNumber = phoneNumber
    }
    
    public var body: some View {
        RoutingView(router: router) {
            VStack(alignment: .leading, spacing: .zero) {
                WQTopBar(style: .navigation(
                    .init(
                        title: "",
                        action: {
                            router.navigateBack()
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
                                input: $verificationCodeInput,
                                isValid: $isVerificationCodeValid,
                                timeLimit: $verificationCodeTimeLimit,
                                resendHandler: {
                                    authManager.verifyPhoneNumber(
                                        phoneNumber
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
        }
        .onChange(of: isVerificationCodeValid) { isValid in
            guard verificationCodeTimeLimit > 0 else {
                verificationCodeInvalidToastModel = .init(status: .warning, text: "인증번호 시간이 만료됐어요\n재전송을 눌러 다시 시도해 주세요")
                return
            }
            if isValid {
                authManager.signIn(with: verificationCodeInput) { result in
                    
                    verificationCodeInput = ""
                    isVerificationCodeValid = false
                    
                    switch result {
                    case .success(let isSucceed):
                        if isSucceed {
                            verificationCodeTimeLimit = 180
                            router.push(spec: .userInformationInput)
                        }
                    case .failure(let reason):
                        switch reason {
                        case .invalidCode:
                            verificationCodeInvalidToastModel = .init(status: .warning, text: "인증번호가 올바르지 않아요")
                        case .timeout:
                            verificationCodeInvalidToastModel = .init(status: .warning, text: "인증번호가 만료됐어요. 다시 시도해 주세요")
                        case .unknown:
                            verificationCodeInvalidToastModel = .init(status: .warning, text: "잠시 후 다시 시도해 주세요")
                        }
                    }
                }
            }
        }
        .toast(model: $verificationCodeInvalidToastModel)
    }
}

struct VerificationCodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodeInputView(router: .init(isPresented: .constant(.userInformationInput)), phoneNumber: "12341234")
    }
}
