//
//  View+Modal.swift
//  DesignSystemKit
//
//  Created by AhnSangHoon on 2023/06/10.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct OneButtonModalModifier: ViewModifier {
    private let model: WQModal.Style.OneButtonAlertModel
    @Binding var isPresented: Bool
    
    public init(model: WQModal.Style.OneButtonAlertModel, isPresented: Binding<Bool>) {
        self.model = model
        self._isPresented = isPresented
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            WQModal(style: .oneButton(model), isPresented: $isPresented)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

public struct TwoButtonModalModifier: ViewModifier {
    private let model: WQModal.Style.TwoButtonAlertModel
    @Binding var isPresented: Bool
    
    public init(model: WQModal.Style.TwoButtonAlertModel, isPresented: Binding<Bool>) {
        self.model = model
        self._isPresented = isPresented
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            WQModal(style: .twoButton(model), isPresented: $isPresented)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

public extension View {
    func modal(_ style: WQModal.Style.OneButtonAlertModel, isPresented: Binding<Bool>) -> some View {
        modifier(OneButtonModalModifier(model: style, isPresented: isPresented))
    }
    
    func modal(_ style: WQModal.Style.TwoButtonAlertModel, isPresented: Binding<Bool>) -> some View {
        modifier(TwoButtonModalModifier(model: style, isPresented: isPresented))
    }
}
