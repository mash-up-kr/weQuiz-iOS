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
        case certifcationNumber
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
            case .certifcationNumber:
                Text("11234")
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
}
