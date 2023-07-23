import SwiftUI

import MainKit

import AuthenticationUI
import HomeUI

public struct ContentView: View {
    public init() {}

    public var body: some View {
        if isLoggedIn {
            OnboardingView()
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
