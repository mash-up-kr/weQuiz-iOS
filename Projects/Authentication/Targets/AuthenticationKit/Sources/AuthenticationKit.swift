import Foundation

import FirebaseCore

public final class AuthenticationKit {
    public static func initializeFirebase() {
        FirebaseApp.configure()
    }
    
    public static var didFnish: (() -> Void)?
}
