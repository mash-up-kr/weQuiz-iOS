//
//  RemovedQuizView.swift
//  Quiz
//
//  Created by AhnSangHoon on 2023/07/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct RemovedQuizView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("문제 불러오기 실패")
                .font(.pretendard(.regular, size: ._20))
                .foregroundColor(.designSystem(.g4))
            Text("삭제된 문제에요 🥶")
                .font(.pretendard(.medium, size: ._32))
                .foregroundColor(.designSystem(.g1))
        }
    }
}

struct RemovedQuizView_Previews: PreviewProvider {
    static var previews: some View {
        RemovedQuizView()
    }
}
