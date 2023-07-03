import SwiftUI

import AuthenticationUI
import AuthenticationKit
import DesignSystemKit

@main
struct AuthenticationApp: App {
    init() {
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    
    @StateObject private var router = AuthenticationRouter(isPresented: .constant(.main))
    
    var body: some Scene {
        WindowGroup {
            OnboardingView(router: router)
        }
    }
}
