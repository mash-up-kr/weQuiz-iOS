//
//  ContentView.swift
//  WeQuiz
//
//  Created by AhnSangHoon on 2023/08/02.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainNavigator: MainNavigator
    
    private let authenticationNavigator: AuthenticationNavigator = .shared
    private let homeNavigator: HomeNavigator = .shared
    
    var body: some View {
        Group {
            switch mainNavigator.root {
            case .home:
                HomeView()
                    .configureView()
                    .environmentObject(homeNavigator)
            case .authentication:
                OnboardingView()
                    .environmentObject(authenticationNavigator)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
