//
//  UserInformationInputInteractor.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public final class UserInformationInputInteractor {
    private let presenter: UserInformationInputPresentingLogic
    private let authManager: AuthManager
    
    private let authenticationService: AuthenticationServiceLogic?
    
    public init(
        presenter: UserInformationInputPresentingLogic,
        authManager: AuthManager,
        authenticationService: AuthenticationServiceLogic?
    ) {
        self.presenter = presenter
        self.authManager = authManager
        self.authenticationService = authenticationService
    }
}

extension UserInformationInputInteractor: UserInformationInputRequestingLogic {
    public func request(_ request: UserInformationInputModel.Request.OnTouchNavigationBack) {
        presenter.present(UserInformationInputModel.Response.Navigate.init(destination: .back))
    }
    
    public func request(_ request: UserInformationInputModel.Request.OnRequestSignUp) {
        presenter.present(UserInformationInputModel.Response.Progress(show: true))
        guard let token = authManager.userId else {
            presenter.present(UserInformationInputModel.Response.Toast(type: .signUpFailed(reason: "유효하지 않은 휴대폰 인증정보입니다")))
            presenter.present(UserInformationInputModel.Response.Progress(show: false))
            return
        }
        
        let model: JoinRequestModel = .init(
            token: token,
            phone: request.phone,
            nickname: request.nickname,
            description: request.description
        )
        
        authenticationService?.join(model) { [weak self] result in
            self?.presenter.present(UserInformationInputModel.Response.Progress(show: false))
            switch result {
            case .success:
                AuthManager.shared.storeToken {
                    self?.presenter.present(.init(destination: .finish(request.nickname)))
                }
            case .failure(let error):
                guard case let .fail(reason) = error else {
                    self?.presenter.present(UserInformationInputModel.Response.Toast(type: .unknown))
                    return
                }

                self?.presenter.present(UserInformationInputModel.Response.Toast(type: .signUpFailed(reason: reason)))
            }
        }
    }
}

public protocol UserInformationInputRequestingLogic {
    func request(_ request: UserInformationInputModel.Request.OnTouchNavigationBack)
    func request(_ request: UserInformationInputModel.Request.OnRequestSignUp)
}
