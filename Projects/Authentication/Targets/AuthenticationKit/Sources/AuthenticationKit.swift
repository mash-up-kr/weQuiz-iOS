import Foundation

import FirebaseCore

public final class AuthenticationKit {
    public static func hello() {
        print("Hello, from your Kit framework")
    }
    
    public static func initializeFirebase() {
        FirebaseApp.configure()
    }
}
