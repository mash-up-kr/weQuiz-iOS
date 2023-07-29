import SwiftUI

import DesignSystemKit

import MainUI
import MainKit

import HomeKit
import HomeUI

import AuthenticationKit
import AuthenticationUI

@main
struct MainApp: App {
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            initializeFirebase()
            return true
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            
        }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        }
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        _ = try? DesignSystemKit.Pretendard.registerFonts()
    }
    
    var root: ModuleViewNavigator {
        if isLoggedIn {
            return ModuleViewNavigator(rootView: .home)
        } else {
            return ModuleViewNavigator(rootView: .authentication)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(navigator: root)
        }
    }
}
