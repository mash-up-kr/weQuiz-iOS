//
//  Image+Icon.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/05/27.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension Image {
    init(_ representable: any IconRepresentable) {
        self = .init(representable.name, bundle: Bundle(identifier: DesignSystemKit.bundleId)!)
    }
}
