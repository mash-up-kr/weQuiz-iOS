//
//  PhoneNumberInputView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/27.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import AuthenticationKit
import DesignSystemKit

public struct PhoneNumberInputView: View {
    @ObservedObject var presenter: PhoneNumberInputPresenter
    
    @State private var phoneNumberInput: String = ""
    @State private var isPhoneNubmerValid: Bool = false
    @State private var phoneNumberInvalidToastModel: WQToast.Model?
    
    private var interactor: PhoneNumberInputRequestingLogic?
    private let signType: AuthenticationScreen.SignType
    
    private var title: String {
        switch signType {
        case .signUp:
            return "회원가입을 위해\n휴대폰 번호를 입력해주세요"
        case .signIn:
            return "반가워요!\n휴대폰 번호로 로그인 해주세요"
        }
    }
    
    public init(
        interactor: PhoneNumberInputRequestingLogic,
        presenter: PhoneNumberInputPresenter,
        _ signType: AuthenticationScreen.SignType = .signUp
    ) {
        self.interactor = interactor
        self.presenter = presenter
        self.signType = signType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            WQTopBar(style: .navigation(
                .init(
                    title: "",
                    action: {
                        interactor?.request(PhoneNumberInputModel.Request.OnTouchNavigationBack())
                    })
            ))
            VStack(alignment: .leading, spacing: .zero) {
                Text(title)
                    .font(.pretendard(.bold, size: ._24))
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 36)
                VStack(alignment: .leading, spacing: 12) {
                    Text("휴대폰번호")
                        .font(.pretendard(.medium, size: ._12))
                        .foregroundColor(.designSystem(.g2))
                    // TODO: ClearButton 터치 시 isVaild 변경되지 않는 이슈 있음
                    WQInputField(style: .phoneNumber(
                        .init(
                            input: $phoneNumberInput,
                            isValid: $isPhoneNubmerValid,
                            placeholder: "휴대폰 번호 입력"
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
            WQButton(
                style: .fullRadiusSingle(
                    .init(
                        title: "인증번호 받기",
                        isEnable: .constant(!$phoneNumberInput.wrappedValue.isEmpty && $isPhoneNubmerValid.wrappedValue),
                        action: {
                            interactor?.request(
                                PhoneNumberInputModel.Request.OnTouchGetVerificationCode(
                                    signType: signType,
                                    input: phoneNumberInput
                                )
                            )
                        }
                    )
                )
            )
        }
        .onChange(of: phoneNumberInput) { input in
            // ClearButton 터치 시 isVaild 변경되지 않아 임시 처리
            if input.isEmpty {
                isPhoneNubmerValid = false
            }
        }
        .onChange(of: presenter.viewModel.toastModel) { model in
            switch model {
            case .exceededLimit:
                phoneNumberInvalidToastModel = .init(status: .warning, text: "인증한도를 초과했습니다. 개발자에게 문의해주세요")
            case .unknown:
                phoneNumberInvalidToastModel = .init(status: .warning, text: "잠시 후 다시 시도해 주세요")
            }
        }
        .toast(model: $phoneNumberInvalidToastModel)
    }
}

struct PhoneNumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = PhoneNumberInputPresenter(navigator: .shared)
        let interactor = PhoneNumberInputInteractor(presenter: presenter, authManager: .shared)
        PhoneNumberInputView(
            interactor: interactor,
            presenter: presenter
        )
    }
}
