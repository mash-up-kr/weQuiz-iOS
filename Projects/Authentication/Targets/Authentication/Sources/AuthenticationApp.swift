import UserNotifications
import SwiftUI

import AuthenticationUI
import AuthenticationKit
import DesignSystemKit

import FirebaseAuth

@main
struct AuthenticationApp: App {
    class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            AuthenticationKit.initializeFirebase()
            return true
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            #if DEBUG
            Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
            #else
            Auth.auth().setAPNSToken(deviceToken, type: .prod)
            #endif
        }
        
        func application(
            _ application: UIApplication,
            didReceiveRemoteNotification notification: [AnyHashable : Any],
            fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
        ) {
            if Auth.auth().canHandleNotification(notification) {
                completionHandler(.noData)
                return
            }
        }
        
        func application(
            _ application: UIApplication, open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any]
        ) -> Bool {
            if Auth.auth().canHandle(url) {
                return true
            }
            return true
        }
        
        func application(
            _ application: UIApplication,
            configurationForConnecting connectingSceneSession: UISceneSession,
            options: UIScene.ConnectionOptions
        ) -> UISceneConfiguration {
            let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            sceneConfig.delegateClass = SceneDelegate.self
            return sceneConfig
        }
        
        
        func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            willPresent notification: UNNotification,
            withCompletionHandler completionHandler:
            @escaping (UNNotificationPresentationOptions) -> Void
        ) {
            completionHandler([[.banner, .sound, .badge]])
        }
        
    }
    
    class SceneDelegate: NSObject, UIWindowSceneDelegate {
        var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let _ = (scene as? UIWindowScene) else { return }
        }
        
        func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
          for urlContext in URLContexts {
              let url = urlContext.url
              Auth.auth().canHandle(url)
          }
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
