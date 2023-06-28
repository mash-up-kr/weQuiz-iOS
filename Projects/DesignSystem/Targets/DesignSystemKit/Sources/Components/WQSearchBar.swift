//
//  WQSearchBar.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/06.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct WQSearchBar: View {
    @Binding var input: String
    @Binding var placeholder: String
    
    var onSubmit: (() -> Void)?
    
    public init(
        input: Binding<String>,
        placeholder: Binding<String>,
        onSubmit: (() -> Void)? = nil
    ) {
        self._input = input
        self._placeholder = placeholder
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        ZStack {
            TextField(
                "WQSearchBar",
                text: $input,
                prompt:
                    Text($placeholder.wrappedValue)
                    .foregroundColor(.designSystem(.g4))
            )
            .onSubmit {
                onSubmit?()
            }
            .foregroundColor(.designSystem(.g9))
            .padding(
                .init(
                    top: 8,
                    leading: 16,
                    bottom: 8,
                    trailing: 16
                )
            )
            .clearButton(
                .init(textFieldInput: $input, image: Image(Icon.Close.fillBlack))
            )
            .tint(.designSystem(.p1))
            
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.designSystem(.g7))
        )
    }
}


struct WQSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        WQSearchBar(
            input: .init(projectedValue: .constant("")),
            placeholder: .init(projectedValue: .constant("Placeholder"))
        )
    }
}
