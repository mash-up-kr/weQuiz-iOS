//
//  QuizResultRankCell.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import QuizKit
import DesignSystemKit

struct QuizResultRankView: View {
    
    private let model: RankUserModel
    
    public init(_ model: RankUserModel) {
        self.model = model
    }
    
    var body: some View {
        HStack(alignment: .center) {
            
            ZStack {
                // TODO: 메달 아이콘으로 수정
                Image(Icon.Checkmark.falseFill20)
                    .resizable()
                .frame(width: 24, height: 24)
                .hidden(model.rank > 3)
                
                Text("\(model.rank)")
                    .font(.pretendard(.bold, size: ._18))
                    .foregroundColor(Color.designSystem(.g4))
                    .hidden(model.rank <= 3)
            }
            
            Text("\(model.name)")
                .font(.pretendard(.regular, size: ._16))
                .foregroundColor(Color.designSystem(.g2))
            
            Text("#\(model.id)")
                .font(.pretendard(.regular, size: ._10))
                .foregroundColor(Color.white)
            
            Spacer()
            
            Text("\(model.score)점")
                .font(.pretendard(.medium, size: ._18))
                .foregroundColor(Color.designSystem(.g1))
        }
        .padding(.horizontal, 16)
        .frame(height: 58)
        
    }
}

struct QuizResultRankCell_Previews: PreviewProvider {
    static var previews: some View {
        QuizResultRankView(.init(id: 1234, name: "감자", rank: 1, score: 100))
    }
}
