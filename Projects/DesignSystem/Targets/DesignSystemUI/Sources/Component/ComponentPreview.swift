//
//  ComponentPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/03.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct ComponentPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                WQButtonPreview()
                WQSearchBarPreview()
                WQTopBarPreview()
            }
        }
        .safeAreaInset(
            edge: .bottom,
            content: {
                Spacer()
                    .frame(height: 15)
            }
        )
        .navigationTitle("Component")
    }
}
