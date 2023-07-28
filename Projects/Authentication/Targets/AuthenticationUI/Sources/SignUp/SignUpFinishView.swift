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
    private let nickname: String
    
    init(nickname: String) {
        self.nickname = nickname
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 53) {
            RoundedRectangle(cornerRadius: 27)
                .frame(width: 150, height: 150)
            Text("반가워요\n\(nickname)")
                .multilineTextAlignment(.center)
                .font(.pretendard(.bold, size: ._34))
        }
    }
}

struct SignUpFinishView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFinishView(nickname: "테스트닉네임")
    }
}
