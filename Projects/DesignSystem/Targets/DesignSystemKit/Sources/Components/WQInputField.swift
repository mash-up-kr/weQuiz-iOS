//
//  WQInputField.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//


import SwiftUI

public struct WQInputField: View {
    public enum Style {
        case phoneNumber(PhoneNumberStyleModel)
        case verificationCode(VerificationCodeStyleModel)
        case nickname
    }
    
    private let placeholder: String? = nil
    private let style: Style
    @FocusState private var isFocused: Bool

    public init(
        style: Style
    ) {
        self.style = style
    }

    public var body: some View {
        VStack {
            switch style {
            case .phoneNumber(let model):
                phoneNumberInputField(model)
                    .focused($isFocused)
            case .verificationCode(let model):
                verificationCodeInputField(model)
                    .focused($isFocused)
            case .nickname:
                Text("11234")
            }
            Rectangle()
                .foregroundColor(isFocused ? .designSystem(.p1) : .white)
                .frame(height: 2)
                .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
    }
    
    private func phoneNumberInputField(_ model: Style.PhoneNumberStyleModel) -> some View {
        WQPhoneNumberTextField(
            text: model.$input,
            isValid: model.$isValid
        )
        .didEndEditing(model.didEndEditing)
        .placeholder(placeholder ?? "")
        .font(.medium, ._20)
        .foregroundColor(.designSystem(.g2))
        .padding(
            .init(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
        )
        .fixedSize(horizontal: false, vertical: true)
        .clearButton(
            .init(
                textFieldInput: model.$input,
                image: Image(Icon.Close.fillWhite)
            )
        )
        .tint(.designSystem(.p1))
    }
    
    private func verificationCodeInputField(_ model: Style.VerificationCodeStyleModel) -> some View {
        ZStack(alignment: .trailing) {
            WQVerificationCodeTextField(
                input: model.$input,
                isValid: model.$isValid
            )
            .font(.medium, ._20)
            .foregroundColor(.designSystem(.g2))
            .padding(
                .init(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0
                )
            )
            .fixedSize(horizontal: false, vertical: true)
            .tint(.designSystem(.p1))
            HStack(spacing: 4) {
                let minute = model.$timeLimit.wrappedValue / 60
                let second = model.$timeLimit.wrappedValue % 60
                let time = minute == .zero ? String(format: "%02d", second) : "\(minute):\(String(format: "%02d", second))"
                Text(time)
                    .font(.pretendard(.regular, size: ._14))
                    .foregroundColor(.designSystem(.p1))
                    .padding(.trailing, 4)
                Button {
                    model.resendHandler?()
                } label: {
                    Text("재전송")
                        .font(.pretendard(.medium, size: ._12))
                        .foregroundColor(.white)
                        .padding(.init(
                            top: 4,
                            leading: 6,
                            bottom: 4,
                            trailing: 6
                        ))
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(.designSystem(.g8))
                        }
                }
            }
        }
    }
}

struct WQInputField_Previews: PreviewProvider {
    static var previews: some View {
        WQInputField(style:
            .phoneNumber(
                .init(
                    input: .constant(""),
                    isValid: .constant(false)
                )
            )
        )
        WQInputField(style:.verificationCode(
            .init(
                input: .constant(""),
                isValid: .constant(false),
                timeLimit: .constant(180),
                resendHandler: {
                    print("재전송 버튼 눌림")
                }
            )
        ))
    }
}

public extension WQInputField.Style {
    struct PhoneNumberStyleModel {
        @Binding public var input: String
        @Binding public var isValid: Bool
        var didEndEditing: ((UITextField) -> Void)?
        
        public init(
            input: Binding<String>,
            isValid: Binding<Bool>,
            didEndEditing: ((UITextField) -> Void)? = nil
        ) {
            self._input = input
            self._isValid = isValid
            self.didEndEditing = didEndEditing
        }
    }
    
    struct VerificationCodeStyleModel {
        @Binding public var input: String
        @Binding public var isValid: Bool
        @Binding public var timeLimit: Int
        public var resendHandler: (() -> Void)?
        
        public init(
            input: Binding<String>,
            isValid: Binding<Bool>,
            timeLimit: Binding<Int>,
            resendHandler: (() -> Void)? = nil
        ) {
            self._input = input
            self._isValid = isValid
            self._timeLimit = timeLimit
            self.resendHandler = resendHandler
        }
    }
}
