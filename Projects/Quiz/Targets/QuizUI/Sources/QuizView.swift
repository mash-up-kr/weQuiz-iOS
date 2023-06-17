//
//  QuizView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/17.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

public struct QuizView: View {
    var title: String = ""
    
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.designSystem(.g4))
                .padding(.all, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
        .background(
            Color.designSystem(.g8)
        )
    }
}
