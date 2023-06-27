import SwiftUI

import AuthenticationUI
import DesignSystemKit

@main
struct AuthenticationApp: App {
    init() {
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
