//
//  AuthenticationNavigator.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum AuthenticationScreen: Hashable {
    public enum SignType {
        case signIn
        case signUp
    }
    case phoneNumber(SignType)
    case verificationCodeInput(String, SignType)
    case userInformationInput(String)
    case signUpFinsh(String)
}

public final class AuthenticationNavigator: ObservableObject {
    @Published public var path: [AuthenticationScreen] = []
    
    private init() { }
    
    public static let shared: AuthenticationNavigator = .init()
    
    public func back() {
        path = path.dropLast()
    }
}
