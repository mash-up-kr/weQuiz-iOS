//
//  View+.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
