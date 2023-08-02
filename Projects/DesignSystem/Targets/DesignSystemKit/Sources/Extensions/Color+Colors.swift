//
//  Color+Colors.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension Color {
    static func designSystem(_ color: DesignSystemKit.Colors) -> Color {
        .init(color.name, bundle: Bundle(identifier: DesignSystemKit.bundleId)!)
    }
}
