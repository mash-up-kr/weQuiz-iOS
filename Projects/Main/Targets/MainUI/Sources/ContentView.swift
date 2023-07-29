import SwiftUI

import AuthenticationKit
import AuthenticationUI

import MainKit

import HomeUI

public struct ContentView: View {
    @ObservedObject var navigator: ModuleViewNavigator
    
    private let authenticationNavigator: AuthenticationNavigator = .shared
    
    public init(navigator: ModuleViewNavigator) {
        self.navigator = navigator
    }

    public var body: some View {
        Group {
            if navigator.viewIdentifier == .home {
                Home()
                    .environmentObject(HomeViewModel())
            } else {
                OnboardingView()
                    .environmentObject(authenticationNavigator)
                    .navigationBarBackButtonHidden()
                    .onAppear {
                        AuthenticationKit.didFnish = {
                            navigator.viewIdentifier = .home
                        }
                    }
            }
        }
    }
}
