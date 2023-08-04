//
//  UserInformationInputPresenter.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public final class UserInformationInputPresenter: ObservableObject {
    @Published public var viewModel: UserInformationInputViewModel = .default
    
    private let navigator: AuthenticationNavigator
    
    public init(navigator: AuthenticationNavigator) {
        self.navigator = navigator
    }
}

extension UserInformationInputPresenter: UserInformationInputPresentingLogic {
    public func present(_ response: UserInformationInputModel.Response.Navigate) {
        switch response.destination {
        case .back:
            navigator.back()
        case .finish(let nickname):
            navigator.path = [
                .signUpFinsh(nickname)
            ]
        }
    }
    
    public func present(_ response: UserInformationInputModel.Response.Toast) {
        viewModel.toastModel = response.type
    }
}

public protocol UserInformationInputPresentingLogic {
    func present(_ response: UserInformationInputModel.Response.Navigate)
    func present(_ response: UserInformationInputModel.Response.Toast)
}
