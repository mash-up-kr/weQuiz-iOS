import SwiftUI

import AuthenticationUI
import AuthenticationKit
import DesignSystemKit

@main
struct AuthenticationApp: App {
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          AuthenticationKit.initializeFirebase()
        return true
      }
    }
    
    init() {
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var router = AuthenticationRouter(isPresented: .constant(.main))
    
    var body: some Scene {
        WindowGroup {
            OnboardingView(router: router)
        }
    }
}
