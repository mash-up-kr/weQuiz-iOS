//
//  AuthenticationRouter.swift
//  AuthenticationUI
//
//  Created by AhnSangHoon on 2023/06/30.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI


//public final class AuthenticationRouter: Router {
//    func push(spec: ViewSpec) {
//        switch spec {
//        case .main:
//            break
//        case .phoneNumberInput:
//            navigateTo(.phoneNumberInput)
//        case .verificationCodeInput(let phoneNumber):
//            navigateTo(.verificationCodeInput(phoneNumber))
//        case .userInformationInput:
//            navigateTo(.userInformationInput)
//        }
//    }
//
//    public override func view(spec: ViewSpec, route: Route) -> AnyView {
//        AnyView(buildView(spec: spec, route: route))
//    }
//}
//
//private extension AuthenticationRouter {
//    @ViewBuilder
//    func buildView(spec: ViewSpec, route: Route) -> some View {
//        switch spec {
//        case .phoneNumberInput:
//            PhoneNumberInputView(router: router(route: route))
//        case .verificationCodeInput(let phoneNumber):
//            let presenter = VerificationCodeInputPresenter()
//            VerificationCodeInputView(
//                router: router(route: route),
//                interactor: VerificationCodeInputInteractor(
//                    presenter: presenter
//                ),
//                presenter: presenter,
//                phoneNumber: phoneNumber
//            )
//        case .userInformationInput:
//            UserInformationInputView(router: router(route: route))
//        default:
//            EmptyView()
//        }
//    }
//
//    func router(route: Route) -> AuthenticationRouter {
//        switch route {
//        case .navigation:
//            return self
//        case .sheet:
//            return self
//        case .fullScreenCover:
//            return self
//        case .modal:
//            return self
//        }
//    }
//}
