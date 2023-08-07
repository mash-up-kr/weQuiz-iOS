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
        presenter?.present(VerificationCodeInputModel.Response.Progress(show: true))
        presenter?.present(VerificationCodeInputModel.Response.Toast(type: .resendCode))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.authManager.verifyPhoneNumber(
                request.phoneNumber
            ) { [weak self] result in
                self?.presenter?.present(VerificationCodeInputModel.Response.Progress(show: false))
                switch result {
                case .success:
                    self?.presenter?.present(VerificationCodeInputModel.Response.ResetTimer())
                case .failure(let message):
                    self?.presenter?.present(VerificationCodeInputModel.Response.Toast(type: .errorMessage(message.localizedDescription)))
                }
            }
        }
    }
    
    public func reqeust(_ request: VerificationCodeInputModel.Request.OnRequestVerifyCode) {
        presenter?.present(VerificationCodeInputModel.Response.Progress(show: true))
        guard request.remainTime > 0 else {
            presenter?.present(VerificationCodeInputModel.Response.Progress(show: false))
            presenter?.present(VerificationCodeInputModel.Response.InputReset(needRest: true))
            presenter?.present(VerificationCodeInputModel.Response.Toast(type: .timeout))
            return
        }
        
        guard request.isValid else {
            presenter?.present(VerificationCodeInputModel.Response.Progress(show: false))
            presenter?.present(VerificationCodeInputModel.Response.InputReset(needRest: true))
            presenter?.present(VerificationCodeInputModel.Response.Toast(type: .unknown))
            return
        }
        
        authManager.registerPhoneNumber(with: request.code) { [weak self] result in
            switch result {
            case let .success(response):
                guard response.0, let userId = response.1 else {
                    self?.presenter?.present(VerificationCodeInputModel.Response.Toast(type: .unknown))
                    return
                }
                
                Task {
                    await self?.signIn(request, userId)
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
                self?.presenter?.present(VerificationCodeInputModel.Response.Progress(show: false))
                self?.presenter?.present(VerificationCodeInputModel.Response.InputReset(needRest: true))
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

extension VerificationCodeInputInteractor {
    private func signIn(
        _ request: VerificationCodeInputModel.Request.OnRequestVerifyCode,
        _ userId: String
    ) async {
        if let userInfromation = await authenticationService.user(userId) {
            // 회원정보가 있다면 토큰 저장하고 홈으로
            authManager.storeToken { [weak self] in
                self?.presenter?.present(VerificationCodeInputModel.Response.Progress(show: false))
                self?.presenter?.present(
                    VerificationCodeInputModel.Response.Naivgate(
                        destination: .home(userInfromation.nickname)
                    )
                )
            }
        } else {
            switch request.type {
            case .signIn:
                presenter?.present(VerificationCodeInputModel.Response.Progress(show: false))
                presenter?.present(VerificationCodeInputModel.Response.InputReset(needRest: true))
                // 회원정보가 없으면 회원가입 모달 노출
                presenter?.present(VerificationCodeInputModel.Response.Modal(type: .notSignedUpUser))
            case .signUp:
                signUp(request.phoneNumber)
            }
        }
    }
    
    private func signUp(_ phoneNumber: String) {
        presenter?.present(
            VerificationCodeInputModel.Response.Naivgate(
                destination: .userInformationInput(
                    phoneNumber
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
