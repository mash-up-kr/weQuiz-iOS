//
//  QuizResultView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import QuizKit
import DesignSystemKit


public struct QuizResultView: View {
    
    public let model: QuizResultModel
    
    public init(_ model: QuizResultModel) {
        self.model = model
    }
    
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
                        .hidden(model.ranking == nil)
                }
            }
            .padding(.top, 58)
            .padding(.bottom, 128)
            .disabled(model.ranking == nil)
            
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
            Text("\(model.myScore)")
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
            Text("\(model.myNickname)과 \(model.friendNickname)는")
                .foregroundColor(Color.designSystem(.g4))
                .font(.pretendard(.regular, size: ._18))
                .frame(height: 26)
            
            Text("\(getScoreDescription(model.myScore))")
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
            if let ranking = model.ranking {
                ForEach(ranking, id: \.id) { user in
                    QuizResultRankView(user)
                }
                .padding(.horizontal, 20)
            }
            
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
    
    // TODO: - 통신 추가하면 모델 만드는 쪽으로 이동
    private func getScoreDescription(_ score: Int) -> String {
        switch score {
        case 90...100:
            return "영혼을 공유한 사이"
        case 70..<90:
            return "아직 거리가 있는 친구"
        case 50..<70:
            return "거리가 머네요"
        case 30..<50:
            return "그냥 얼굴만 아는 사이"
        default:
            return "엽짚보다도 못한 사이"
        }
    }
}
struct QuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        // Ranking 있는 경우
        QuizResultView(
            .init(myScore: 100, myNickname: "두루미", friendNickname: "두더지",
                  ranking: [RankUserModel(id: 1111, name: "감자", rank: 1, score: 100),
                            RankUserModel(id: 2434, name: "족제비", rank: 2, score: 98),
                            RankUserModel(id: 3555, name: "원숭이", rank: 3, score: 95),
                            RankUserModel(id: 2335, name: "메타몽", rank: 4, score: 77),
                            RankUserModel(id: 3252, name: "강아지", rank: 5, score: 60),
                            RankUserModel(id: 4556, name: "오리", rank: 6, score: 51)]))
        // 랭킹 없는 경우
//        QuizResultView(.init(myScore: 100, myNickname: "두루미", friendNickname: "두더지"))
    }
}
