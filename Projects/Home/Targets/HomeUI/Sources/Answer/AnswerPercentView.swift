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

enum answerNum: Int {
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    case fifth = 5
    
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
