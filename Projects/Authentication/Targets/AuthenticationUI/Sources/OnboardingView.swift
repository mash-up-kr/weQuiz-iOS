import SwiftUI

import DesignSystemKit

public struct OnboardingView: View {
    public init() {}

    public var body: some View {
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
                            // TODO: Move to SignUp
                        }
                    )
                )
            )
            HStack {
                Text("이미 계정이 있나요?")
                    .font(.pretendard(.regular, size: ._14))
                    .foregroundColor(.designSystem(.g2))
                Button("로그인") {
                    // TODO: Move to SignIn
                }
                .font(.pretendard(.bold, size: ._14))
                .foregroundColor(.designSystem(.p1))
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
