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
    @EnvironmentObject var authenticationNavigator: AuthenticationNavigator
    @EnvironmentObject var homeNavigator: HomeNavigator
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    
    var body: some View {
        Group {
            switch mainNavigator.root {
            case .home:
                HomeView()
                    .configureView()
            case .authentication:
                OnboardingView()
            }
        }
        .fullScreenCover(
            isPresented: $mainNavigator.showQuiz) {
                if let showQuizModel = mainNavigator.showQuizModel {
                    switch showQuizModel {
                    case .solve(let id):
                        SolveQuizIntroView(quizId: id)
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
