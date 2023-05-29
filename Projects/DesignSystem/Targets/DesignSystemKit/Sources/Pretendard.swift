//
//  Pretendard.swift
//  DesignSystemKit
//
//  Created by Ahn Sang Hoon on 2023/05/24.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import CoreText

public extension DesignSystemKit {
    enum Pretendard {}
}

public extension DesignSystemKit.Pretendard {
    enum Weight: String, CaseIterable {
        case regular
        case medium
        case semibold
        case bold
        
        public var fontName: String {
            switch self {
            case .regular:
                return "PretendardJP-Regular"
                
            case .medium:
                return "PretendardJP-Medium"
                
            case .semibold:
                return "PretendardJP-SemiBold"
                
            case .bold:
                return "PretendardJP-Bold"
            }
        }
    }
}


extension DesignSystemKit.Pretendard {
    @discardableResult
    /// Pretendard Font를 등록합니다
    public static func registerFonts() throws -> Bool {
        try Weight.allCases.allSatisfy {
            try DesignSystemKit.Pretendard.registerFont(
                bundle: .init(identifier: DesignSystemKit.bundleId)!,
                fontName: $0.fontName,
                fontExtension: "otf"
            )
        }
    }
}

extension DesignSystemKit.Pretendard {
    @discardableResult
    fileprivate static func registerFont(
        bundle: Bundle,
        fontName: String,
        fontExtension: String
    ) throws -> Bool {
        guard
            let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
            let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
            let _ = CGFont(fontDataProvider)
        else {
            fatalError("Couldn't create font from filename: \(fontName).\(fontExtension)")
        }
        
        var error: Unmanaged<CFError>?
        
        let isSuccess = CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
        
        if let error = error?.takeUnretainedValue() {
            throw error
        }
        
        return isSuccess
    }
}
