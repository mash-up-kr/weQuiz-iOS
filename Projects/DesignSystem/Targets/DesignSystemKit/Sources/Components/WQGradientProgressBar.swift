//
//  WQGradientProgressBar.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct WQGradientProgressBar: View {
    private struct WQProgressViewStyle: ProgressViewStyle {
        func makeBody(configuration: Configuration) -> some View {
            let fractionCompleted = configuration.fractionCompleted ?? 0
            ZStack(alignment: .topLeading) {
                GeometryReader { proxy in
                    Rectangle()
                        .foregroundStyle(
                            DesignSystemKit.Gradient.gradientS1.linearGradient
                        )
                        .frame(
                            maxWidth: proxy.size.width * CGFloat(fractionCompleted)
                        )
                }
            }
        }
    }

    private let standard: Int
    @Binding private var current: Int
    @State private var width: CGFloat = .infinity
    
    public init(
        standard: Int,
        current: Binding<Int>
    ) {
        self.standard = standard
        self._current = current
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .foregroundColor(.designSystem(.g8))
            ProgressView(value: CGFloat(current), total: CGFloat(standard))
                .frame(height: 2)
                .progressViewStyle(WQProgressViewStyle())
        }
        .animation(.easeInOut, value: current)
    }
}

struct WQGradientProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        WQGradientProgressBar(standard: 3, current: .constant(3))
    }
}
