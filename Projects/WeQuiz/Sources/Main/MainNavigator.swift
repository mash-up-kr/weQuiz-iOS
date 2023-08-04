//
//  MainNavigator.swift
//  WeQuiz
//
//  Created by AhnSangHoon on 2023/08/04.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import Foundation

final class MainNavigator: ObservableObject {
    enum MainRootScreen {
        case home
        case authentication
    }
    
    enum PresentQuiz {
        case solve(id: Int)
        case result(id: Int, solver: String)
    }
    
    @Published var root: MainRootScreen
    @Published var showQuiz: Bool = false
    var showQuizModel: PresentQuiz?
    
    static let shared: MainNavigator = .init()
    
    private init() {
        if let _ = AuthManager.shared.token {
            self.root = .home
        } else {
            self.root = .authentication
        }
    }
}

extension MainNavigator {
    func showSolveQuiz(_ id: Int) {
        showQuiz = true
        showQuizModel = .solve(id: id)
    }
    
    func showQuizResult(_ id: Int, solverId: String) {
        showQuiz = true
        showQuizModel = .result(id: id, solver: solverId)
    }
}
