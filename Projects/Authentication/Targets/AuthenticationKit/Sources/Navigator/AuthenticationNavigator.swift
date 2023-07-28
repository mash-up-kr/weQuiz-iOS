//
//  AuthenticationNavigator.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum Screen: Hashable {
    case phoneNumber
    case verificationCodeInput(String)
    case userInformationInput(String)
    case signUpFinsh(String)
}

public final class AuthenticationNavigator: ObservableObject {
    @Published public var path: [Screen] = []
    
    private init() { }
    
    public static let shared: AuthenticationNavigator = .init()
    
    public func back() {
        path = path.dropLast()
    }
}
