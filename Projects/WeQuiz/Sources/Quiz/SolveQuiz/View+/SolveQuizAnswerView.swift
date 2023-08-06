//
//  SolveQuizAnswerView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/07/19.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct SolveQuizAnswerView: View {
    private enum AnswerColor: Int {
        case gradientS1 = 0
        case gradientS2
        case gradientS3
        case gradientS4
        case gradientS5
        case unknown
        
        init(rawValue: Int) {
            switch rawValue {
            case 0: self = .gradientS1
            case 1: self = .gradientS2
            case 2: self = .gradientS3
            case 3: self = .gradientS4
            case 4: self = .gradientS5
            default: self = .unknown
            }
        }
        
        var gradient: LinearGradient {
            switch self {
            case .gradientS1: return DesignSystemKit.Gradient.gradientS1.linearGradient
            case .gradientS2: return DesignSystemKit.Gradient.gradientS2.linearGradient
            case .gradientS3: return DesignSystemKit.Gradient.gradientS3.linearGradient
            case .gradientS4: return DesignSystemKit.Gradient.gradientS4.linearGradient
            case .gradientS5: return DesignSystemKit.Gradient.gradientS5.linearGradient
            case .unknown: return .linearGradient(
                colors: [Color.designSystem(.s1)],
                startPoint: .zero,
                endPoint: .init(x: 1, y: 1)
            )
            }
        }
    }
    
    @Binding private var model: SolveAnswerModel
    private let currentAnswerIndex: Int
    
    public init(_ model: Binding<SolveAnswerModel>, _ currentAnswerIndex: Int) {
        self._model = model
        self.currentAnswerIndex = currentAnswerIndex
    }
    
    public var body: some View {
        Text(model.answer)
            .font(.pretendard(.bold, size: ._18))
            .foregroundColor(model.isSelected ? Color.designSystem(.g9) : .designSystem(.g2))
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 58)
            .background(
                backgroundColor()
            )
            .cornerRadius(16)
            .onTapGesture {
                model.isSelected.toggle()
            }
    }
}

extension SolveQuizAnswerView {
    func backgroundColor() -> some View {
        Group {
            if model.isSelected {
                AnswerColor(rawValue: currentAnswerIndex).gradient
            } else {
                Color.designSystem(.g8)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: model.isSelected)
    }
}
