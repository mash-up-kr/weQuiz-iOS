//
//  QuizCompletionView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import QuizKit
import DesignSystemKit

public struct QuizCompletionView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var isSharePresented = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            VStack {
                WQTopBar(style: .navigationWithButtons(.init(title: "문제 만들기", bttons: [], action: {
                    self.presentation.wrappedValue.dismiss()
                })))
                
                Spacer()
                
                WQButton(
                  style: .single(
                      .init(title: "친구들에게 시험지 공유하기",
                          action: {
                              self.isSharePresented = true
                          }))
                )
                .frame(height: 52)
                .background(
                    ActivityView(
                        isPresented: $isSharePresented,
                        activityItems: ["친구가 만든 찐친고사에 도전해보세요!", URL(string: "https://www.youtube.com/")!])
                    // TODO: - url 문제 id로 수정
                )
            }
            
            VStack {
                // TODO: - 이미지 수정
                Image(Icon.Siren.mono)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .background(Color.designSystem(.g1))
                    .cornerRadius(27)
                    
                
                Text("시험지를 완성했어요!")
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
}

struct QuizCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        QuizCompletionView()
    }
}
