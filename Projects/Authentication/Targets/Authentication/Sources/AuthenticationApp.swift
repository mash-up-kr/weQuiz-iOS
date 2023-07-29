import UserNotifications
import SwiftUI

import AuthenticationUI
import AuthenticationKit
import DesignSystemKit

@main
struct AuthenticationApp: App {
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            AuthenticationKit.initializeFirebase()
            return true
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            
        }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        }
    }
    
    init() {
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let navigator = AuthenticationNavigator.shared
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environmentObject(navigator)
        }
    }
}
