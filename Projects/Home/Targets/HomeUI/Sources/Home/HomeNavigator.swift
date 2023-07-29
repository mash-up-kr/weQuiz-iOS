//
//  HomeNavigator.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum Screen: Hashable {
    case friendRankView
    case questionGroupView
    case questionDetail
}


public final class HomeNavigator: ObservableObject {
    @Published public var path: [Screen] = []

    private init() { }

    public static let shared: HomeNavigator = .init()

    public func back() {
        path = path.dropLast()
    }
}
