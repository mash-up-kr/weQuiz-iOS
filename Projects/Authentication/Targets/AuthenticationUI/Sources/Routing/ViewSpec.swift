//
//  ViewSpec.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/30.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum ViewSpec: Equatable, Hashable {
    case main
    case phoneNumberInput
    case verificationCodeInput(String)
    case userInformationInput
}

extension ViewSpec: Identifiable {
    public var id: Self { self }
}
