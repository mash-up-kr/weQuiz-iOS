//
//  QuestionRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct QuestionGroupRow: View {
    let questionGroup: QuestionGroup
    
    var body: some View {
        HStack {
            self.questionsDescription
        }
        .frame(height: 56)
        .background(.gray)
        .cornerRadius(12)
    }
}

extension QuestionGroupRow {
    var questionsDescription: some View {
        HStack {
            Text(questionGroup.title)
            Spacer()
        }
        .padding(.all, 16)
    }
}
