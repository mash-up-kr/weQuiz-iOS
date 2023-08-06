//
//  QuizCompletionView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct QuizCompletionView: View {
    @State var isSharePresented = false
    @State var activityItems: [Any] = []

    private var navigator: HomeNavigator
    private var quizId: Int    
    
    public init(quizId: Int, navigator: HomeNavigator) {
        self.quizId = quizId
        self.navigator = navigator
    }
    
    public var body: some View {
        ZStack {
            VStack {
                WQTopBar(style: .navigationWithButtons(.init(title: "문제 만들기", bttons: [], action: {
                    navigator.path = []
                })))
                
                Spacer()
                
                WQButton(
                  style: .single(
                      .init(title: "친구들에게 시험지 공유하기",
                          action: {
                              quizLink(id: quizId)
                          }))
                )
                .frame(height: 52)
                .background(
                    ActivityView(
                        isPresented: $isSharePresented,
                        activityItems: activityItems
                    )
                )
            }
            
            VStack(spacing: 16) {
                WeQuizAsset.Assets.quizMakeSuccess.swiftUIImage
                
                Text("WeQuiz\n시험지를 완성했어요!")
                    .multilineTextAlignment(.center)
                    .font(.pretendard(.bold, size: ._24))
                    .foregroundColor(Color.designSystem(.g1))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 60)
            
        }
        .background(
            Color.designSystem(.g9)
        )
        .navigationBarHidden(true)
    }
    
    private func quizLink(id: Int) {
        DynamicLinks.makeDynamicLink(type: .solve(id: id)) {
            guard let url = $0 else { return }
            activityItems = ["친구가 만든 찐친고사에 도전해보세요!\n\n\(url)"]
            isSharePresented = true
        }
    }
}

struct QuizCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        QuizCompletionView(quizId: 1, navigator: HomeNavigator.shared)
    }
}
