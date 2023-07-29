import SwiftUI

import AuthenticationKit
import MainKit

import AuthenticationUI
import HomeUI

public struct ContentView: View {
    private let authenticationNavigator: AuthenticationNavigator = .shared
    
    public init() {}

    public var body: some View {
        if isLoggedIn {
            OnboardingView()
                .environmentObject(authenticationNavigator)
        } else {
            Home()
                .environmentObject(HomeViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
