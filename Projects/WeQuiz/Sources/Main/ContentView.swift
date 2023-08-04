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
    private let solveQuizNavigator: SolveQuizNavigator = .shared
    
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
        .fullScreenCover(
            isPresented: $mainNavigator.showQuiz) {
                if let showQuizModel = mainNavigator.showQuizModel {
                    switch showQuizModel {
                    case .solve(let id):
                        SolveQuizIntroView(quizId: id)
                            .environmentObject(mainNavigator)
                            .environmentObject(solveQuizNavigator)
                    case let .result(id, solverId):
                        EmptyView()
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
