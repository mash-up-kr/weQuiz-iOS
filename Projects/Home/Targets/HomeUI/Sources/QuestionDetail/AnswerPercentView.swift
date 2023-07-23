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
    
    var id: Int
    
    var body: some View {
        Rectangle()
            .fill(answerNum(rawValue: id)?.color ?? Color.designSystem(.s1))
    }
}

struct AnswerPercentView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerPercentView(id: 1)
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
