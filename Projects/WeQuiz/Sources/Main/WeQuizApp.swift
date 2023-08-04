import SwiftUI

import DesignSystemKit

import FirebaseAuth
import FirebaseCore

@main
struct WeQuizApp: App {
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
        ) -> Bool {
            FirebaseApp.configure()
            return true
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            // Pass device token to auth
            Auth.auth().setAPNSToken(deviceToken, type: .prod)
            
            // Further handling of the device token if needed by the app
            // ...
        }
        
        func application(_ application: UIApplication,
                         didReceiveRemoteNotification notification: [AnyHashable : Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            if Auth.auth().canHandleNotification(notification) {
                completionHandler(.noData)
                return
            }
            // This notification is not auth related; it should be handled separately.
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
        
        func application(_ application: UIApplication, open url: URL,
                         options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            if Auth.auth().canHandle(url) {
                return true
            }
            // URL not auth related; it should be handled separately.
            return true
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
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let mainNavigator: MainNavigator = .shared
    
    init() {
        DesignSystemKit.registerFont()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainNavigator)
                .onOpenURL { url in
                    if let quizId = DynamicLinks.id(from: url) {
                        // TODO: Quiz 풀기 혹은 Quiz 결과 화면 Push
                    }
                }
        }
    }
}
