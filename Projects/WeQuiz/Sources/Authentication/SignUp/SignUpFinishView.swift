//
//  SignUpFinishView.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/06/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct SignUpFinishView: View {
    @EnvironmentObject var mainNavigator: MainNavigator
    
    private let nickname: String
    
    private var navigator: AuthenticationNavigator
    
    init(navigator: AuthenticationNavigator, nickname: String) {
        self.navigator = navigator
        self.nickname = nickname
    }

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Image("authentication_finish")
            Text("반가워요\n\(nickname)")
                .multilineTextAlignment(.center)
                .font(.pretendard(.bold, size: ._34))
            Spacer()
                .frame(height: 50)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                mainNavigator.root = .home
            }
        }
    }
}
