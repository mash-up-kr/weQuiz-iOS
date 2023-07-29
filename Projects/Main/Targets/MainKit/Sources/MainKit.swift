import Foundation

import AuthenticationKit

public var isLoggedIn: Bool {
    if let token = AuthManager.shared.token {
        return true
    }
    return false
}
