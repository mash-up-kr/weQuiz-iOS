//
//  WQLimitCharacterTextField.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/21.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct WQLimitCharacterTextField: UIViewRepresentable {
    typealias UIViewType = UITextField
    
    @Binding private var input: String
    @Binding private var isValid: Bool
    
    private let placeholder: String
    private let limit: Int
    private let condition: ((Int) -> Bool)
    var font: UIFont?
    var textColor: UIColor?
    
    init(
        input: Binding<String>,
        isValid: Binding<Bool>,
        placeholder: String,
        limit: Int,
        condition: @escaping ((Int) -> Bool)
    ) {
        self._input = input
        self._isValid = isValid
        self.placeholder = placeholder
        self.limit = limit
        self.condition = condition
    }
    
    func makeUIView(context: Context) -> UITextField {
        let uiView = UITextField()
        uiView.placeholder = placeholder
        uiView.text = input
        uiView.font = font
        uiView.text = input
        uiView.textColor = textColor
        uiView.autocapitalizationType = .none
        uiView.delegate = context.coordinator
        uiView.addTarget(
            context.coordinator,
            action: #selector(Coordinator.didChangeText(_:)),
            for: .editingChanged
        )
        return uiView
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.placeholder = placeholder
        uiView.text = input
        uiView.font = font
        uiView.textColor = textColor
        uiView.autocapitalizationType = .none
    }
    
    func makeCoordinator() -> WQLimitCharacterTextFieldCoordinator {
        .init(
            input: $input,
            isValid: $isValid,
            limit: limit,
            condition: condition
        )
    }
    
    class WQLimitCharacterTextFieldCoordinator: NSObject, UITextFieldDelegate {
        private var input: Binding<String>
        private var isValid: Binding<Bool>
        private let limit: Int
        private let condition: ((Int) -> Bool)
        
        public init(
            input: Binding<String>,
            isValid: Binding<Bool>,
            limit: Int,
            condition: @escaping ((Int) -> Bool)
        ) {
            self.input = input
            self.isValid = isValid
            self.limit = limit
            self.condition = condition
        }
        
        @objc
        public func didChangeText(_ textField: UITextField) {
            input.wrappedValue = textField.text ?? ""
            isValid.wrappedValue = condition(textField.text?.count ?? .zero) && (textField.text?.count ?? .zero >= 1)
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "" { return true }
            
            let textCount = textField.text?.count ?? .zero
            
            guard textCount < limit else { return false }
            return true
        }
    }
}

extension WQLimitCharacterTextField {
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

struct WQLimitCharacterTextField_Previews: PreviewProvider {
    static var previews: some View {
        WQLimitCharacterTextField(
            input: .constant(""),
            isValid: .constant(false),
            placeholder: "placeholder",
            limit: 10,
            condition: {
                $0 < 10
            }
        )
    }
}

