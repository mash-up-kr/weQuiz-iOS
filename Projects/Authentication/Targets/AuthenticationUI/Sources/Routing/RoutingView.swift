//
//  RoutingView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/30.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct RoutingView<Content: View>: View {
    @StateObject var router: Router
    private let content: Content
    
    public init(router: Router, @ViewBuilder content: @escaping () -> Content) {
        _router = StateObject(wrappedValue: router)
        self.content = content()
    }
    
    public var body: some View {
        NavigationStack(path: router.navigationPath) {
            content
                .navigationDestination(for: ViewSpec.self) { spec in
                    router.view(spec: spec, route: .navigation)
                }
                .navigationBarHidden(true)
        }.sheet(item: router.presentingSheet) { spec in
            router.view(spec: spec, route: .sheet)
        }.fullScreenCover(item: router.presentingFullScreen) { spec in
            router.view(spec: spec, route: .fullScreenCover)
        }.modal(item: router.presentingModal) { spec in
            router.view(spec: spec, route: .modal)
        }
    }
}
