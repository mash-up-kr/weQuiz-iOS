//
//  View+ClearButton.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/06.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct ClearButton: ViewModifier {
    @Binding var textFieldInput: String
    let image: Image
    
    public init(textFieldInput: Binding<String>, image: Image) {
        self._textFieldInput = textFieldInput
        self.image = image
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !textFieldInput.isEmpty {
                Button {
                    textFieldInput = ""
                } label: {
                    image
                }
                .padding(.trailing, 8)
            }
        }
    }
}

public extension View {
    func clearButton(_ button: ClearButton) -> some View {
        modifier(
            button
        )
    }
}
