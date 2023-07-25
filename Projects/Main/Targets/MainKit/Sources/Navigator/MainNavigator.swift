//
//  MainNavigator.swift
//  Main
//
//  Created by AhnSangHoon on 2023/07/24.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum MainScreen: Hashable {
    case authentication
    case home
}

public final class MainNavigator: ObservableObject {
    @Published public var path: [MainScreen] = []
    
    private init() { }
    
    public static let shared: MainNavigator = .init()
    
    public func back() {
        path = path.dropLast()
    }
}
