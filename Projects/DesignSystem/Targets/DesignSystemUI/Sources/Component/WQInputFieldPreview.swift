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
    
    @State private var verificationCodeInput: String = ""
    @State private var verificationCodeValidate: Bool = false
    @State private var verificationCodeTimeLimit: Int = 179
    
    private let limitCharacterPlaceholder: String = "Input character"
    @State private var limitCharacterInput: String = ""
    @State private var limitCharacterValidate: Bool = false
    @State private var limitCharacterLimit: Int = 10

    var body: some View {
        VStack(spacing: 50) {
            VStack(alignment: .leading) {
                Text("PhoneNumber")
                    .font(.title)
                WQInputField(style:.phoneNumber(
                    .init(
                        input: $phoneNumberInput,
                        isValid: $phoneNumberValidate,
                        placeholder: phoneNumberPlaceholder
                    )
                ))
            }
            VStack(alignment: .leading) {
                Text("VerificationCode")
                    .font(.title)
                WQInputField(style: .verificationCode(
                    .init(
                        input: $verificationCodeInput,
                        isValid: $verificationCodeValidate,
                        timeLimit: $verificationCodeTimeLimit
                    )
                ))
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
                        if self.verificationCodeTimeLimit > 0 {
                            self.verificationCodeTimeLimit -= 1
                        } else {
                            self.verificationCodeTimeLimit = 179
                        }
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("LimitCharacter")
                    .font(.title)
                WQInputField(style: .limitCharacter(
                    .init(
                        input: $limitCharacterInput,
                        isValid: $limitCharacterValidate,
                        placeholder: limitCharacterPlaceholder,
                        limit: limitCharacterLimit,
                        condition: { value in
                            value < limitCharacterLimit
                        }
                    )
                ))
            }
            Spacer()
        }
    }
}
