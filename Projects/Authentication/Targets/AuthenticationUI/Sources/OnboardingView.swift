import SwiftUI

import AuthenticationKit
import DesignSystemKit

public struct OnboardingView: View {
    @EnvironmentObject var navigator: AuthenticationNavigator
    
    private let authManager: AuthManager = .shared

    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navigator.path) {
            VStack {
                Spacer()
                Text("LOGO")
                    .font(.title)
                Spacer()
                WQButton(
                    style: .single(
                        .init(
                            title: "시작하기",
                            action: {
                                navigator.path.append(.phoneNumber)
                            }
                        )
                    )
                )
                HStack {
                    Text("이미 계정이 있나요?")
                        .font(.pretendard(.regular, size: ._14))
                        .foregroundColor(.designSystem(.g2))
                    Button("로그인") {
                        navigator.path.append(.phoneNumber)
                    }
                    .font(.pretendard(.bold, size: ._14))
                    .foregroundColor(.designSystem(.p1))
                }
            }
            .navigationDestination(for: Screen.self) { type in
                switch type {
                case .phoneNumber:
                    PhoneNumberInputView()
                        .navigationBarBackButtonHidden()
                case .verificationCodeInput(let phoneNumber):
                    verificationCodeInputBuilder(phoneNumber)
                        .navigationBarBackButtonHidden()
                case .userInformationInput:
                    UserInformationInputView()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
    
    private func verificationCodeInputBuilder(_ phoneNumber: String) -> VerificationCodeInputView {
        let presenter = VerificationCodeInputPresenter(navigator: navigator)
        let interactor = VerificationCodeInputInteractor(
            presenter: presenter,
            authManager: authManager
        )
        return VerificationCodeInputView(
            interactor: interactor,
            presenter: presenter,
            phoneNumber: phoneNumber
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
