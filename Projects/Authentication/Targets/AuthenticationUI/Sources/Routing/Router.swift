//
//  Router.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/30.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

open class Router: ObservableObject {
    public enum Route {
        case navigation
        case sheet
        case fullScreenCover
        case modal
    }
    
    public struct State {
        var navigationPath: [ViewSpec] = []
        var presentingSheet: ViewSpec? = nil
        var presentingFullScreen: ViewSpec? = nil
        var presentingModal: ViewSpec? = nil
        var isPresented: Binding<ViewSpec?>
        
        var isPresenting: Bool {
            presentingSheet != nil || presentingFullScreen != nil || presentingModal != nil
        }
    }
    
    @Published private(set) var state: State
    
    public init(isPresented: Binding<ViewSpec?>) {
        state = State(isPresented: isPresented)
    }
    
    open func view(spec: ViewSpec, route: Route) -> AnyView {
        AnyView(EmptyView())
    }
}

public extension Router {
    var navigationPath: Binding<[ViewSpec]> {
        binding(keyPath: \.navigationPath)
    }
    
    var presentingSheet: Binding<ViewSpec?> {
        binding(keyPath: \.presentingSheet)
    }
    
    var presentingFullScreen: Binding<ViewSpec?> {
        binding(keyPath: \.presentingFullScreen)
    }
    
    var presentingModal: Binding<ViewSpec?> {
        binding(keyPath: \.presentingModal)
    }
    
    var isPresented: Binding<ViewSpec?> {
        state.isPresented
    }
}

private extension Router {
    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}

public extension Router {
    func navigateTo(_ viewSpec: ViewSpec) {
        state.navigationPath.append(viewSpec)
    }
    
    func navigateBack() {
        state.navigationPath.removeLast()
    }
    
    func replaceNavigationStack(path: [ViewSpec]) {
        state.navigationPath = path
    }
    
    func presentSheet(_ viewSpec: ViewSpec) {
        state.presentingSheet = viewSpec
    }
    
    func presentFullScreen(_ viewSpec: ViewSpec) {
        state.presentingFullScreen = viewSpec
    }
    
    func presentModal(_ viewSpec: ViewSpec) {
        state.presentingModal = viewSpec
    }
    
    func dismiss() {
        if state.presentingSheet != nil {
            state.presentingSheet = nil
        } else if state.presentingFullScreen != nil {
            state.presentingFullScreen = nil
        } else if state.presentingModal != nil {
            state.presentingModal = nil
        } else if navigationPath.count > 1 {
            state.navigationPath.removeLast()
        } else {
            state.isPresented.wrappedValue = nil
        }
    }
}
