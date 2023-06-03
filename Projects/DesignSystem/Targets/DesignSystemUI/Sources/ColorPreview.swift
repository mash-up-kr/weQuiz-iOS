//
//  ColorPreview.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct ColorPreview: View {
    let colorDataSet = DesignSystemKit.Colors.allCases
    
    private struct ColorRowView: View {
        let color: DesignSystemKit.Colors
        
        var body: some View {
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 45, height: 45)
                    .foregroundColor(
                        .designSystem(color)
                    )
                Text(color.name)
                    .font(.pretendard(.regular, size: ._18))
                Spacer()
            }
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(colorDataSet.indices, id: \.self) {
                ColorRowView(color: colorDataSet[$0])
            }
        }
        .navigationTitle("Color")
        .padding()
    }
}
