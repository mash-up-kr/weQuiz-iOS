//
//  WQGradientProgressBarPreview.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/07/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct WQGradientProgressBarPreview: View {
    private let standard: Int = 10
    @State private var current: Int = .zero
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("GradientProgressBar")
                .font(.title)
            VStack {
                WQGradientProgressBar(
                    standard: standard,
                    current: $current
                )
                Button("버튼을 눌러보세요") {
                    if current == standard {
                        current = 0
                    } else {
                        current += 1
                    }
                }
            }
            Spacer()
        }
    }
}
