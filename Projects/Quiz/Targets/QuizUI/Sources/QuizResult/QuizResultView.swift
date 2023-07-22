//
//  QuizResultView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

public struct QuizResultView: View {
    
    public init() {}
    
    @State private var isSharePresented = false
    
    public var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    VStack(alignment: .center, spacing: 20) {
                        socreView()
                        descriptionView()
                    }
                    
                    Image(Icon.Checkmark.trueFill24)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                    
                    rankingView()
                }
            }
            .padding(.top, 58)
            .padding(.bottom, 128)
            
            VStack {
                topBar()
                
                Spacer()
                
                VStack(spacing: 22) {
                    tooltip()
                        .padding(.vertical, 7)
                        .padding(.horizontal, 21)
                        .frame(height: 38)
                        .background(Color.designSystem(.g8))
                        .cornerRadius(19)
                    
                    WQButton(style: .double(WQButton.Style.DobuleButtonStyleModel(
                        titles: (leftTitle: "다시 풀기", rightTitle: "결과 공유하기"),
                        leftAction: {
                        print("다시 풀기 클릭")},
                        rightAction: {
                            isSharePresented = true
                        }
                    )))
                    .background(
                        // TODO: - url 문제 id로 수정
                        ActivityView(
                            isPresented: $isSharePresented,
                            activityItems: ["찐친고사 결과를 확인해보세요!",
                                            URL(string: "https://youtu.be/jOTfBlKSQYY")!]
                        )
                    )
                }
            }
        }
        .background(Color.designSystem(.g9))
    }
}
extension QuizResultView {
    
    private func socreView() -> some View {
        HStack(alignment: .center, spacing: 6) {
            // TODO: - size 68로 수정
            Text("20")
                .foregroundStyle(DesignSystemKit.Gradient.gradientS1.linearGradient)
                .font(.pretendard(.bold, size: ._48))
                .frame(height: 54)
            Text("점")
                .foregroundColor(Color.designSystem(.g1))
                .font(.pretendard(.bold, size: ._18))
                .frame(height: 26)
        }
    }
    
    private func descriptionView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("name1과 name2는")
                .foregroundColor(Color.designSystem(.g4))
                .font(.pretendard(.regular, size: ._18))
                .frame(height: 26)
            
            Text("옆집보다 못한 사이")
                .foregroundColor(Color.designSystem(.g1))
                .font(.pretendard(.bold, size: ._28))
                .frame(height: 38)
        }
    }
    
    private func tooltip() -> some View {
        Text("1분만에 가입해서 친구한테 문제내기 🗯️")
            .foregroundColor(Color.designSystem(.g3))
            .font(.pretendard(.bold, size: ._16))
            .frame(height: 24)
    }
    
    private func rankingView() -> some View {
        VStack {
            Rectangle()
                .fill(Color.designSystem(.g7))
                .frame(height: 8)
            
            // TODO: - 데이터 받아서 수정
            ForEach(0..<3) {_ in
                QuizResultRankCell()
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func topBar() -> some View {
        HStack {
            Spacer()
            
            // TODO: - 홈 아이콘으로 수정
            Image(Icon.Add.circle)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 20)
                .onTapGesture {
                    // TODO: - 홈으로 돌아가기
                    print("홈으로 돌아가기")
                }
        }
        .frame(height: 56)
        .background(Color.designSystem(.g9))
    }
}
