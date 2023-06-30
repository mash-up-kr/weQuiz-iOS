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
    
    @State private var verificationCodeInput: String = ""
    @State private var isVerificationCodeValid: Bool = false
    @State private var verificationCodeTimeLimit: Int = 180
    
    public init(router: AuthenticationRouter) {
        self._router = StateObject(wrappedValue: router)
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
                                    print("재전송")
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
            if isValid {
                verificationCodeInput = ""
                isVerificationCodeValid = false
                verificationCodeTimeLimit = 180
                router.push(spec: .userInformationInput)
            }
        }
    }
}

struct VerificationCodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodeInputView(router: .init(isPresented: .constant(.userInformationInput)))
    }
}
