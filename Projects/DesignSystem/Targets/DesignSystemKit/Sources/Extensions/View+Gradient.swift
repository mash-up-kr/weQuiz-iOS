//
//  View+Gradient.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension View {
    static func linearGradient(_ gradient: DesignSystemKit.Gradient) -> LinearGradient {
        LinearGradient(
            stops: gradient.stops,
            startPoint: gradient.startPont,
            endPoint: gradient.endtPont
        )
    }
}
