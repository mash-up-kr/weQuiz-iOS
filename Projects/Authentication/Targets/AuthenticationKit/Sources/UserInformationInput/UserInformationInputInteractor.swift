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
    
    public init(
        presenter: UserInformationInputPresentingLogic,
        authManager: AuthManager
    ) {
        self.presenter = presenter
        self.authManager = authManager
    }
}

extension UserInformationInputInteractor: UserInformationInputRequestingLogic {
    public func request(_ request: UserInformationInputModel.Request.OnTouchNavigationBack) {
        presenter.present(UserInformationInputModel.Response.Navigate.init(destination: .back))
    }
    
    public func request(_ request: UserInformationInputModel.Request.OnRequestSignUp) {
        // TODO: Networking
        // onSuccess
        AuthManager.shared.storeToken { [weak self] in
            self?.presenter.present(.init(destination: .finish))
        }
        // onFailure
        // presenter.present(UserInformationInputModel.Response.Toast(type: .signUpFailed))
    }
}

public protocol UserInformationInputRequestingLogic {
    func request(_ request: UserInformationInputModel.Request.OnTouchNavigationBack)
    func request(_ request: UserInformationInputModel.Request.OnRequestSignUp)
}
