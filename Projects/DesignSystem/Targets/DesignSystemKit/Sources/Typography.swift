//
//  Typography.swift
//  DesignSystemKit
//
//  Created by Ahn Sang Hoon on 2023/05/24.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension DesignSystemKit {
    enum Typography { }
}

public extension DesignSystemKit.Typography {
    enum Weight: String, Hashable, CaseIterable {
        case regular
        case medium
        case semibold
        case bold
        
        public var pretendard: DesignSystemKit.Pretendard.Weight {
            switch self {
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            }
        }
    }
    
    enum Size: CGFloat {
        case _48 = 48.0
        case _34 = 34.0
        case _32 = 32.0
        case _28 = 28.0
        case _24 = 24.0
        case _20 = 20.0
        case _18 = 18.0
        case _16 = 16.0
        case _14 = 14.0
        case _12 = 12.0
        case _10 = 10.0
    }
    
    enum Semantic {
        case h3
        case h4
        case h5
        case h6
        case title
        case subtitle2
        case subtitle1
        case base
        case caption1
        case caption2
        case xs
        
        public var size: DesignSystemKit.Typography.Size {
            switch self {
            case .h3: return ._48
            case .h4: return ._34
            case .h5: return ._32
            case .h6: return ._28
            case .title: return ._24
            case .subtitle1: return ._20
            case .subtitle2: return ._18
            case .base: return ._16
            case .caption1: return ._14
            case .caption2: return ._12
            case .xs: return ._10
            }
        }
    }
}
