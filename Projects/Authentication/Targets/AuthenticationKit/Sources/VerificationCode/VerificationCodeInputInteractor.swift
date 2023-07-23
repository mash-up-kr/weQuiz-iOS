//
//  VerificationCodeInputInteractor.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public final class VerificationCodeInputInteractor {
    private var presenter: VerificationCodeInputPresentingLogic?
    private let authManager: AuthManager
    
    public init(
        presenter: VerificationCodeInputPresentingLogic,
        authManager: AuthManager
    ) {
        self.presenter = presenter
        self.authManager = authManager
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
        authManager.verifyPhoneNumber(
            request.phoneNumber
        ) { [weak self] isSucceed in
            guard isSucceed else { return }
            self?.presenter?.present(VerificationCodeInputModel.Response.ResetTimer())
        }
    }
    
    public func reqeust(_ request: VerificationCodeInputModel.Request.OnRequestVerifyCode) {
        guard request.remainTime > 0 else {
            presenter?.present(VerificationCodeInputModel.Response.Toast(type: .timeout))
            return
        }
        
        guard request.isValid else {
            presenter?.present(VerificationCodeInputModel.Response.Toast(type: .unknown))
            return
        }
        
        authManager.signIn(with: request.code) { [weak self] result in
            switch result {
            case .success(let isSucceed):
                if isSucceed {
                    self?.presenter?.present(
                        VerificationCodeInputModel.Response.Naivgate(destination: .userInformationInput)
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
}

public protocol VerificationCodeInputRequestingLogic {
    func reqeust(_ request: VerificationCodeInputModel.Request.OnLoad)
    func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchNavigationBack)
    func reqeust(_ request: VerificationCodeInputModel.Request.OnTouchReSend)
    func reqeust(_ request: VerificationCodeInputModel.Request.OnRequestVerifyCode)
}
