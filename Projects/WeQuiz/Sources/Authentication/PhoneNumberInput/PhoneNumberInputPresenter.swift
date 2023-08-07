//
//  PhoneNumberInputPresenter.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public final class PhoneNumberInputPresenter: ObservableObject {
    @Published public var viewModel: PhoneNumberInputViewModel = .default
    
    private var navigator: AuthenticationNavigator
    
    public init(
        navigator: AuthenticationNavigator
    ) {
        self.navigator = navigator
    }
}

extension PhoneNumberInputPresenter: PhoneNumberInputPresentingLogic {
    public func present(_ response: PhoneNumberInputModel.Response.Naivgate) {
        switch response.destination {
        case .back:
            navigator.back()
        case let .verificationCodeInput(phoneNumber, signType):
            navigator.path.append(.verificationCodeInput(phoneNumber, signType))
        }
    }
    
    public func present(_ response: PhoneNumberInputModel.Response.Toast) {
        viewModel.toastModel = .init(type: response.type)
    }
    
    public func present(_ response: PhoneNumberInputModel.Response.Progress) {
        viewModel.progress = response.show
    }
}

public protocol PhoneNumberInputPresentingLogic {
    func present(_ response: PhoneNumberInputModel.Response.Naivgate)
    func present(_ response: PhoneNumberInputModel.Response.Toast)
    func present(_ response: PhoneNumberInputModel.Response.Progress)
}
