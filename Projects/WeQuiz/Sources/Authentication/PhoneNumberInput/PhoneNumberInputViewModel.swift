//
//  PhoneNumberInputViewModel.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct PhoneNumberInputViewModel {
    public var toastModel: PhoneNumberInputModel.Response.Toast = .default
    public var progress: Bool = false
    
    public static let `default`: PhoneNumberInputViewModel = .init()
}
