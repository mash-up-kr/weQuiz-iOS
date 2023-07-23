//
//  Navigator.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum Screen: Hashable {
    case phoneNumber
    case verificationCodeInput(String)
    case userInformationInput
}

public final class Navigator: ObservableObject {
    @Published public var path: [Screen] = []
    
    private init() { }
    
    public static let shared: Navigator = .init()
    
    public func back() {
        path = path.dropLast()
    }
}
