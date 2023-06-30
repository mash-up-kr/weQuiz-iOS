//
//  WQVerificationCodeTextField.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/19.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct WQVerificationCodeTextField: UIViewRepresentable {
    typealias UIViewType = UITextField
    
    @Binding private var input: String
    @Binding private var isValid: Bool
    
    private let placeholder: String = "6자리 숫자"
    var font: UIFont?
    var textColor: UIColor?
    
    init(
        input: Binding<String>,
        isValid: Binding<Bool>
    ) {
        self._input = input
        self._isValid = isValid
    }
    
    func makeUIView(context: Context) -> UITextField {
        let uiView = UITextField()
        uiView.keyboardType = .numberPad
        uiView.textContentType = .oneTimeCode
        uiView.placeholder = placeholder
        uiView.text = input
        uiView.font = font
        uiView.text = input
        uiView.textColor = textColor
        uiView.delegate = context.coordinator
        uiView.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didChangeText(_:)),
            for: .editingChanged
        )
        return uiView
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.keyboardType = .numberPad
        uiView.textContentType = .oneTimeCode
        uiView.placeholder = placeholder
        uiView.text = input
        uiView.font = font
        uiView.textColor = textColor
    }
    
    func makeCoordinator() -> WQVerificationCodeTextFieldCoordinator {
        .init(
            input: $input,
            isValid: $isValid
        )
    }

    class WQVerificationCodeTextFieldCoordinator: NSObject, UITextFieldDelegate {
        private var input: Binding<String>
        private var isValid: Binding<Bool>
        
        public init(
            input: Binding<String>,
            isValid: Binding<Bool>
        ) {
            self.input = input
            self.isValid = isValid
        }
        
        @objc
        public func didChangeText(_ textField: UITextField) {
            input.wrappedValue = textField.text ?? ""
            isValid.wrappedValue = validation(textField.text)
        }
        
        private func validation(_ text: String?) -> Bool {
            guard let number = text else { return false }
            
            var validate: Bool = true
            
            if number.count < 6 {
                // 13자리가 아닌경우
                validate = false
            }
            
            return validate
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "" { return true }
            
            let textCount = textField.text?.count ?? .zero
            
            guard textCount < 6 else { return false }
            return true
        }
    }
}

extension WQVerificationCodeTextField {
    func font(_ weight: DesignSystemKit.Typography.Weight, _ size: DesignSystemKit.Typography.Size) -> Self {
        var view = self
        view.font = UIFont(name: weight.pretendard.fontName, size: size.rawValue)
        return view
    }
    
    func textColor(_ color: DesignSystemKit.Colors) -> Self {
        var view = self
        view.textColor = UIColor(named: color.name)
        return view
    }
}

struct WQCertificationNumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        WQVerificationCodeTextField(
            input: .constant(""),
            isValid: .constant(false)
        )
    }
}
