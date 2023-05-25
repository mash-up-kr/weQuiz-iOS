//
//  Font+.swift
//  DesignSystem
//
//  Created by Ahn Sang Hoon on 2023/05/25.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension Font {
    static func pretendard(_ weight: DesignSystemKit.Typography.Weight = .regular, sementic: DesignSystemKit.Typography.Semantic = .base) -> Font {
        .pretendard(weight, sementic.size.rawValue)
    }
    
    static func pretendard(_ weight: DesignSystemKit.Typography.Weight = .regular, size: DesignSystemKit.Typography.Size = ._16) -> Font {
        .pretendard(weight, size.rawValue)
    }
    
    private static func pretendard(_ weight: DesignSystemKit.Typography.Weight, _ size: CGFloat) -> Font {
        .custom(weight.pretendard.fontName, size: size)
    }
}

