//
//  SolveQuizAnswerView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/19.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import QuizKit

public struct SolveQuizAnswerView: View {
    
    @Binding private var model: SolveAnswerModel
    
    public init(_ model: Binding<SolveAnswerModel>) {
        self._model = model
    }
    
    public var body: some View {
        Text(model.answer)
            .font(.pretendard(.bold, size: ._18))
            .foregroundColor(model.isSelected ? Color.designSystem(.g9) : .designSystem(.g2))
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 58)
            .background($model.isSelected.wrappedValue ? Color.designSystem(.s1) : Color.designSystem(.g8))
            .cornerRadius(16)
            .onTapGesture {
                $model.isSelected.wrappedValue.toggle()
            }
    }
}
