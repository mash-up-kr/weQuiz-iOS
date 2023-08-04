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
    
    @Published var root: MainRootScreen
    
    static let shared: MainNavigator = .init()
    
    private init() {
        if let _ = AuthManager.shared.token {
            self.root = .home
        } else {
            self.root = .authentication
        }
    }
}
