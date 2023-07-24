//
//  VerificationCodeInputViewModel.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct VerificationCodeInputViewModel {
    public var remainTime: Int = .zero
    public var toastModel: VerificationCodeInputModel.Response.Toast.`Type` = .unknown
    
    public static let `default`: Self = .init()
}
