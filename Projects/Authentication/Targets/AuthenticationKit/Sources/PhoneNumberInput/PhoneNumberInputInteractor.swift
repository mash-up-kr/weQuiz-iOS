//
//  PhoneNumberInputInteractor.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public final class PhoneNumberInputInteractor {
    private let presenter: PhoneNumberInputPresentingLogic
    private let authManager: AuthManager
    
    public init(
        presenter: PhoneNumberInputPresentingLogic,
        authManager: AuthManager
    ) {
        self.presenter = presenter
        self.authManager = authManager
    }
}

extension PhoneNumberInputInteractor: PhoneNumberInputRequestingLogic {
    public func request(_ request: PhoneNumberInputModel.Request.OnTouchNavigationBack) {
        presenter.present(
            PhoneNumberInputModel.Response.Naivgate(
                destination: .back
            )
        )
    }
    
    public func request(_ request: PhoneNumberInputModel.Request.OnTouchGetVerificationCode) {
        authManager.verifyPhoneNumber(request.input, completion: { isSucceed in
            guard isSucceed else {
                self.presenter.present(PhoneNumberInputModel.Response.Toast(type: .unknown))
                return
            }
            self.presenter.present(
                PhoneNumberInputModel.Response.Naivgate(
                    destination: .verificationCodeInput(request.input)
                )
            )
        })
    }
}


public protocol PhoneNumberInputRequestingLogic {
    func request(_ request: PhoneNumberInputModel.Request.OnTouchNavigationBack)
    func request(_ request: PhoneNumberInputModel.Request.OnTouchGetVerificationCode)
}
