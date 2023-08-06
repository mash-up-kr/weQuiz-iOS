//
//  View+ProgressView.swift
//  DesignSystemKit
//
//  Created by 박소현 on 2023/08/06.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct ProgressModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    public func body(content: Content) -> some View {
        content
            .disabled(isPresented)
            .overlay(content: {
                if self.isPresented == true {
                    ProgressView()
                }
            })
    }
}
public extension View {
    func progressView(isPresented: Binding<Bool>) -> some View {
        self.modifier(ProgressModifier(isPresented: isPresented))
    }
}
