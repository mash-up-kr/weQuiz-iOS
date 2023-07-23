//
//  AlphabetCircleView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/06.
//  Copyright © 2023 ommaya.io. All rights reserved.

import SwiftUI
import DesignSystemKit

public struct AlphabetCircleView: View {
    
    var answerNumber: Int = 0
    
    public init(answerNumber: Int) {
        self.answerNumber = answerNumber
    }
    public var body: some View {
        Text(String(UnicodeScalar(answerNumber + 64)!))
            .font(.pretendard(.medium, size: ._16))
            .foregroundColor(
                Color.designSystem(.g2)
            )
            .frame(width: 24, height: 24, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.designSystem(.g2),
                            lineWidth: 1.5)
            )
    }
}

struct AlphabetCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetCircleView(answerNumber: 0)
    }
}
