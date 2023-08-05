//
//  SolveQuizNavigator.swift
//  WeQuiz
//
//  Created by AhnSangHoon on 2023/08/04.
//  Copyright © 2023 wequiz.io. All rights reserved.
//

import Foundation

public enum SolveQuizScreen: Hashable {
    case input(Int, SolveQuizModel)
    case solve(Int, SolveQuizModel)
}

public final class SolveQuizNavigator: ObservableObject {
    @Published public var path: [SolveQuizScreen] = []
    
    private init() { }
    
    public static let shared: SolveQuizNavigator = .init()
    
    public func back() {
        path = path.dropLast()
    }
    
    func popToroot() {
        path = []
    }
}
