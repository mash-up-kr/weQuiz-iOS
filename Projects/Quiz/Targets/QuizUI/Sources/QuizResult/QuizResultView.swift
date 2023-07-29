//
//  QuizResultView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import SwiftUI
import QuizKit
import DesignSystemKit

protocol QuizResultDisplayLogic {
    func displayRanking(viewModel: QuizResult.LoadRanking.ViewModel)
}

public struct QuizResultView: View {
    var interactor: QuizResultBusinessLogic?
    
    @ObservedObject var model = QuizResultDataStore()

    @Binding var isPresented: Bool
    @State private var isSharePresented = false
    
    public init(isPresented: Binding<Bool>, quizId: Int,_ quizResult: QuizResultModel) {
        self._isPresented = isPresented
        self.model.quizId = quizId
        self.model.result = quizResult
    }
    
    public var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack {
                    VStack(alignment: .center, spacing: 20) {
                        if let result = model.result {
                            socreView(result.myScore)
                            descriptionView(me: result.myNickname, friend: result.friendNickname, myScore: result.myScore)
                        }
                        
                    }

                    Image(Icon.Checkmark.trueFill24)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)

                    rankingView()
                        .hidden(model.result?.ranking == nil)
                }
            }
            .padding(.top, 58)
            .padding(.bottom, 128)
            .disabled(model.result?.ranking == nil)

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
                            isPresented = false
                        },
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
        .task {
            if let quizId = model.quizId {
                interactor?.requestRanking(request: .init(quizId: quizId))
            }
        }
    }
}
extension QuizResultView: QuizResultDisplayLogic {
    func displayRanking(viewModel: QuizResult.LoadRanking.ViewModel) {
        self.model.result?.ranking = viewModel.rank
    }
}
extension QuizResultView {

    private func socreView(_ score: Int) -> some View {
        HStack(alignment: .center, spacing: 6) {
            // TODO: - size 68로 수정
            Text("\(score)")
                .foregroundStyle(DesignSystemKit.Gradient.gradientS1.linearGradient)
                .font(.pretendard(.bold, size: ._48))
                .frame(height: 54)
            Text("점")
                .foregroundColor(Color.designSystem(.g1))
                .font(.pretendard(.bold, size: ._18))
                .frame(height: 26)
        }
    }

    private func descriptionView(me: String, friend: String, myScore: Int) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(me) & \(friend)")
                .foregroundColor(Color.designSystem(.g4))
                .font(.pretendard(.regular, size: ._18))
                .frame(height: 26)

            Text("\(getScoreDescription(myScore))")
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

            if let ranking = model.result?.ranking {
                ForEach(ranking, id: \.rank) { user in
                    QuizResultRankView(user)
                }
                .padding(.horizontal, 20)
            }
        }
    }

    private func topBar() -> some View {
        HStack {
            Spacer()

            Image(Icon.Home.fillGray)
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
