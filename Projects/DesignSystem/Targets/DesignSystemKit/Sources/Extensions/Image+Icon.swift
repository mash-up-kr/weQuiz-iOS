//
//  Image+Icon.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/05/27.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension Image {
    static func icon(_ type: any IconRepresentable) -> Image {
        image(type.name)
    }
    
    private static func image(_ name: String) -> Image {
        .init(name, bundle: Bundle(identifier: DesignSystemKit.bundleId)!)
    }
}
