//
//  AnimatableModifier.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0

    public var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }

    public func body(content: Content) -> some View {
        content.frame(height: height)
    }
}
