//
//  View+Toast.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/26.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct ToastModifier: ViewModifier {
    @Binding var toastModel: WQToast.Model?
    @State private var workItem: DispatchWorkItem?
    
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(content: {
                ZStack {
                    toast()
                        .offset(y: -30)
                }
                .animation(.spring(), value: toastModel)
            })
            .onChange(
                of: toastModel
            ) { _ in
               showToast()
            }
    }
    
    @ViewBuilder func toast() -> some View {
        if let toastModel = toastModel {
            VStack {
                Spacer()
                WQToast(model: toastModel)
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let _ = toastModel else { return }
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        let task = DispatchWorkItem {
            workItem?.cancel()
            dismissToast()
        }
        
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: task)
    }
    
    private func dismissToast() {
        withAnimation {
            toastModel = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

public extension View {
    func toast(model: Binding<WQToast.Model?>) -> some View {
        self.modifier(ToastModifier(toastModel: model))
    }
}
