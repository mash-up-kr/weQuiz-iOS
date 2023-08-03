//
//  AlphabetCircleView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct AlphabetCircleView: View {
    
    var answerNumber: Int = 0
    var textColor: Color
    
    public init(answerNumber: Int, textColor: Color) {
        self.answerNumber = answerNumber
        self.textColor = textColor
    }
    public var body: some View {
        Text(String(UnicodeScalar(answerNumber + 65)!))
            .font(.pretendard(.medium, size: ._16))
            .foregroundColor(
                textColor
            )
            .frame(width: 24, height: 24, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(textColor,
                            lineWidth: 1.5)
            )
    }
}

struct AlphabetCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AlphabetCircleView(answerNumber: 0, textColor: Color.designSystem(.g4))
    }
}
