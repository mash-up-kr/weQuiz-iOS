//
//  VerificationCodeInputInteractor.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

@MainActor
public final class VerificationCodeInputInteractor {
    private var presenter: VerificationCodeInputPresentingLogic?
    private let authManager: AuthManager
    private let authenticationService: AuthenticationServiceLogic
    
    public init(
        presenter: VerificationCodeInputPresentingLogic,
        authManager: AuthManager,
        authenticationService: AuthenticationServiceLogic
    ) {
        self.presenter = presenter
        self.authManager = authManager
        self.authenticationService = authenticationService
    }
}

extension VerificationCodeInputInteractor: VerificationCodeInputRequestingLogic {
    public func reqeust(_ request: VerificationCodeInputModel.Request.OnLoad) {
        presenter?.present(VerificationCodeInputModel.Response.ResetTimer())
    }
    
    public func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchNavigationBack) {
        presenter?.present(VerificationCodeInputModel.Response.Naivgate(destination: .back))
    }
    
    
    public func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchReSend) {
        presenter?.present(VerificationCodeInputModel.Response.Toast(type: .resendCode))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.authManager.verifyPhoneNumber(
                request.phoneNumber
            ) { [weak self] isSucceed in
                guard isSucceed else { return }
                self?.presenter?.present(VerificationCodeInputModel.Response.ResetTimer())
            }
        }
    }
    
    public func reqeust(_ request: VerificationCodeInputModel.Request.OnRequestVerifyCode) async {
        guard request.remainTime > 0 else {
            presenter?.present(VerificationCodeInputModel.Response.Toast(type: .timeout))
            return
        }
        
        guard request.isValid else {
            presenter?.present(VerificationCodeInputModel.Response.Toast(type: .unknown))
            return
        }

        let userInformation = await authenticationService.user(authManager.verificationID ?? "")
        
        guard request.type == .signUp, userInformation != nil else {
            presenter?.present(VerificationCodeInputModel.Response.Modal(type: .notSignedUpUser))
            return
        }
        authManager.registerPhoneNumber(with: request.code) { [weak self] result in
            switch result {
            case .success(let isSucceed):
                if isSucceed {
                    self?.presenter?.present(
                        VerificationCodeInputModel.Response.Naivgate(
                            destination: .userInformationInput(
                                request.phoneNumber
                            )
                        )
                    )
                }
            case .failure(let reason):
                switch reason {
                case .invalidCode:
                    self?.presenter?.present(VerificationCodeInputModel.Response.Toast(type: .invalidCode))
                case .timeout:
                    self?.presenter?.present(VerificationCodeInputModel.Response.Toast(type: .expiredCode))
                case .unknown:
                    self?.presenter?.present(VerificationCodeInputModel.Response.Toast(type: .unknown))
                }
            }
        }
    }
    
    public func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchSignUp) {
        presenter?.present(
            VerificationCodeInputModel.Response.Naivgate(
                destination: .userInformationInput(
                    request.phoneNumber
                )
            )
        )
    }
}

public protocol VerificationCodeInputRequestingLogic {
    func reqeust(_ request: VerificationCodeInputModel.Request.OnLoad)
    func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchNavigationBack)
    func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchReSend)
    @MainActor func reqeust(_ request: VerificationCodeInputModel.Request.OnRequestVerifyCode) async
    func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchSignUp)
}
