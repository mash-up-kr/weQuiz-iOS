//
//  QuizResultRankCell.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct QuizResultRankCell: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(Icon.Checkmark.falseFill20)
                .resizable()
                .frame(width: 24, height: 24)
            
            Text("{닉네임}")
                .font(.pretendard(.regular, size: ._16))
                .foregroundColor(Color.designSystem(.g2))
            
            Text("#{고유번호}")
                .font(.pretendard(.regular, size: ._10))
                .foregroundColor(Color.white)
            
            Spacer()
            
            Text("{100}점")
                .font(.pretendard(.medium, size: ._18))
                .foregroundColor(Color.designSystem(.g1))
        }
        .padding(.horizontal, 16)
        .frame(height: 58)
        
    }
}

struct QuizResultRankCell_Previews: PreviewProvider {
    static var previews: some View {
        QuizResultRankCell()
    }
}
