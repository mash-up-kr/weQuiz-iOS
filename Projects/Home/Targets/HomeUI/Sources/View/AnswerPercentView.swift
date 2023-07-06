//
//  AnswerPercentView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/06.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct AnswerPercentView: View {
    
    var index: Int
    @Binding var isHidden: Bool
    
    var body: some View {
        Rectangle()
            .fill(answerNum(rawValue: index)?.color ?? Color.designSystem(.s1))
            .hidden(isHidden)
    }
}

struct AnswerPercentView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerPercentView(index: 1, isHidden: .constant(false))
    }
}

enum answerNum: Int {
    case first = 0
    case second
    case third
    case fourth
    case fifth
    
    var color: Color {
        switch self {
        case .first: return Color.designSystem(.s1)
        case .second: return Color.designSystem(.s2)
        case .third: return Color.designSystem(.s3)
        case .fourth: return Color.designSystem(.s4)
        case .fifth: return Color.designSystem(.s5)
        }
    }
}
