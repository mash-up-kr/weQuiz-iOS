import Foundation

import AuthenticationKit

import FirebaseCore

public func initializeFirebase() {
    FirebaseApp.configure()
}

public var isLoggedIn: Bool {
    if let _ = AuthManager.shared.token {
        return true
    }
    return false
}

public enum ModuleView {
    case authentication
    case home
    case solveQuiz
}

public class ModuleViewNavigator: ObservableObject {
    @Published public var viewIdentifier : ModuleView
    
    public init(rootView: ModuleView) {
        self.viewIdentifier = rootView
    }
}
