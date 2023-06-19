//
//  WQInputFieldPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/16.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct WQInputFieldPreview: View {
    private let phoneNumberPlaceholder: String = "Input PhoneNumber"
    @State private var phoneNumberInput: String = ""
    @State private var phoneNumberValidate: Bool = false
    
    var body: some View {
        VStack {
            Text("PhoneNumber")
                .font(.title)
            WQInputField(style:.phoneNumber(
                .init(
                    input: $phoneNumberInput,
                    isValid: $phoneNumberValidate
                )
            ))
            Spacer()
        }
    }
}
