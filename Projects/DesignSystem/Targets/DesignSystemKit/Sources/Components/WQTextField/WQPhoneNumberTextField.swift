//
//  WQPhoneNumberTextField.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/17.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct WQPhoneNumberTextField: UIViewRepresentable {
    typealias UIViewType = UITextField
    
    @Binding private var text: String
    @Binding private var isValid: Bool
    
    private let placeholder: String
    var font: UIFont?
    var textColor: UIColor?
    
    var didChange: ((String?) -> Void)? = nil
    var didEndEditing: ((UITextField) -> Void)? = nil
    
    init(
        text: Binding<String>,
        isValid: Binding<Bool>,
        placeholder: String
    ) {
        self._text = text
        self._isValid = isValid
        self.placeholder = placeholder
    }
    
    func makeUIView(context: Context) -> UITextField {
        let uiView = UITextField()
        uiView.keyboardType = .numberPad
        uiView.textContentType = .telephoneNumber
        uiView.text = text
        uiView.font = font
        uiView.placeholder = placeholder
        uiView.textColor = textColor
        uiView.delegate = context.coordinator
        uiView.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didChangeText(_:)),
            for: .editingChanged)
        return uiView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.keyboardType = .numberPad
        uiView.textContentType = .telephoneNumber
        uiView.text = text
        uiView.font = font
        uiView.placeholder = placeholder
        uiView.textColor = textColor
    }
    
    func makeCoordinator() -> PhoneNumberFieldCoordinator {
        PhoneNumberFieldCoordinator(
            text: $text,
            isValid: $isValid,
            didChange: didChange,
            didEndEditing: didEndEditing
        )
    }
    
    class PhoneNumberFieldCoordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isValid: Binding<Bool>
        var didChange: ((String?) -> Void)?
        var didEndEditing: ((UITextField) -> Void)?
        
        init(
            text: Binding<String>,
            isValid: Binding<Bool>,
            didChange: ((String?) -> Void)? = nil,
            didEndEditing: ((UITextField) -> Void)? = nil
        ) {
            self.text = text
            self.isValid = isValid
            self.didChange = didChange
            self.didEndEditing = didEndEditing
        }
        
        @objc
        public func didChangeText(_ textField: UITextField) {
            text.wrappedValue = textField.text ?? ""
            isValid.wrappedValue = validation(textField.text)
            didChange?(textField.text)
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            didEndEditing?(textField)
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let textCount = textField.text?.count ?? .zero

            // XXX-XXXX-XXXX 이상에서 글자 삭제하는 경우
            if textCount >= 13, string == "" { return true }
            
            // XXX-XXXX-XXXX 이상이라면 입력 불가능
            guard textCount < 13 else { return false }
            
            guard let trimmed = textField.text?.replacingOccurrences(of: "-", with: "") else { return false }
            
            if trimmed.count == 3 || trimmed.count == 7 {
                if string.isEmpty {
                    // 삭제
                    textField.text = "\(textField.text ?? "")"
                } else {
                    textField.text = "\(textField.text ?? "")-"
                }
            }
            
            if string.isEmpty, (trimmed.count == 4 || trimmed.count == 8) {
                // - 삭제
                textField.text = "\(textField.text?.dropLast() ?? "")"
            }
            
            return true
        }
        
        private func validation(_ text: String?) -> Bool {
            guard let number = text?.replacingOccurrences(of: "-", with: "") else { return false }
            
            var validate: Bool = true
            
            if number.count < 11 {
                // 13자리가 아닌경우
                validate = false
            }
            
            if number.hasPrefix("010") == false {
                validate = false
            }
            
            return validate
        }
    }
}

extension WQPhoneNumberTextField {
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
    
    func didChange(_ completion: ((String?) -> Void)? = nil) -> Self {
        var view = self
        view.didChange = completion
        return view
    }
    
    func didEndEditing(_ completion: ((UITextField) -> Void)? = nil) -> Self {
        var view = self
        view.didEndEditing = completion
        return view
    }
}

struct WQPhoneNumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        WQPhoneNumberTextField(
            text: .constant(""),
            isValid: .constant(false),
            placeholder: "placeholder"
        )
    }
}
