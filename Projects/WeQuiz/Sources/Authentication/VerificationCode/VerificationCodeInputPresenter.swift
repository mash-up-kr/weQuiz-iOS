//
//  VerificationCodeInputPresenter.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public final class VerificationCodeInputPresenter: ObservableObject {
    private enum Const {
        static let timeLimit = 120
    }

    @Published public var viewModel: VerificationCodeInputViewModel = .default
    
    private var navigator: AuthenticationNavigator
    private var timer: Timer?
    
    public init(
        navigator: AuthenticationNavigator
    ) {
        self.navigator = navigator
    }
}

extension VerificationCodeInputPresenter: VerificationCodeInputPresentingLogic {
    public func present(_ response: VerificationCodeInputModel.Response.Naivgate) {
        switch response.destination {
        case .back:
            navigator.back()
        case .userInformationInput(let phoneNumber):
            navigator.path.append(.userInformationInput(phoneNumber))
        case .home:
            // TODO: 홈으로 이동시키기
            navigator.path = []
        }
    }
    
    public func present(_ response: VerificationCodeInputModel.Response.ResetTimer) {
        setTimer()
    }

    public func present(_ response: VerificationCodeInputModel.Response.Toast) {
        viewModel.toastModel = response.type
    }
    
    public func present(_ response: VerificationCodeInputModel.Response.Modal) {
        viewModel.modalModel.isPresented = true
        viewModel.modalModel.type = response.type
    }
}

// MARK: - Private
extension VerificationCodeInputPresenter {
    private func setTimer() {
        timer?.invalidate()
        
        viewModel.remainTime = Const.timeLimit
        
        timer = .scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self else { return }
            if self.viewModel.remainTime > 0 {
                self.viewModel.remainTime -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}

public protocol VerificationCodeInputPresentingLogic {
    func present(_ response: VerificationCodeInputModel.Response.Naivgate)
    func present(_ response: VerificationCodeInputModel.Response.ResetTimer)
    func present(_ response: VerificationCodeInputModel.Response.Toast)
    func present(_ response: VerificationCodeInputModel.Response.Modal)
}
