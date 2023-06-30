import SwiftUI

import AuthenticationKit
import DesignSystemKit


public struct OnboardingView: View {
    @StateObject private var router: AuthenticationRouter
    
    public init(router: AuthenticationRouter) {
        self._router = StateObject(wrappedValue: router)
    }
    
    public var body: some View {
        RoutingView(router: router) {
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
                                router.push(spec: .phoneNumberInput)
                            }
                        )
                    )
                )
                HStack {
                    Text("이미 계정이 있나요?")
                        .font(.pretendard(.regular, size: ._14))
                        .foregroundColor(.designSystem(.g2))
                    Button("로그인") {
                        router.push(spec: .phoneNumberInput)
                    }
                    .font(.pretendard(.bold, size: ._14))
                    .foregroundColor(.designSystem(.p1))
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(router: .init(isPresented: .constant(.main)))
    }
}
