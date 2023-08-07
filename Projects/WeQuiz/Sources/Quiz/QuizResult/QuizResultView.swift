//
//  QuizResultView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

protocol QuizResultDisplayLogic {
    func displayRanking(viewModel: QuizResult.LoadRanking.ViewModel)
}

public struct QuizResultView: View {
    @EnvironmentObject var mainNavigator: MainNavigator
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    var interactor: QuizResultBusinessLogic?
    
    @ObservedObject var model: QuizResultDataStore
    @State private var isSharePresented = false
    @State private var activityItem: [Any] = []
    
    public init(quizId: Int,_ quizResult: QuizResultModel) {
        self.model = QuizResultDataStore()
        self.model.quizId = quizId
        self.model.result = quizResult
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .center, spacing: 20) {
                        if let result = model.result {
                            socreView(result.myScore)
                            descriptionView(me: result.myNickname, friend: result.friendNickname, description: result.scoreDescription)
                        }
                    }

                    HStack {
                        Spacer()
                        if let ranking = model.result?.ranking, ranking.count >= 3 {
                            Image(model.result?.resultImage ?? "quizResult_5")
                        } else {
                            Image(model.result?.resultImage ?? "quizResult_5")
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                        Spacer()
                    }

                    rankingView()
                        .hidden(model.result?.ranking == nil)
                    Spacer()
                        .frame(height: 72)
                }
            }
            .padding(.top, 56)
            .padding(.bottom, 72)
            .disabled(model.result?.ranking == nil)

            VStack(spacing: .zero) {
                topBar()

                Spacer()

                VStack(spacing: .zero) {
                    LinearGradient(
                        colors: [.clear, .designSystem(.g9)],
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 1)
                    )
                    .frame(height: 72)
                    WQButton(style: .double(WQButton.Style.DobuleButtonStyleModel(
                        titles: (leftTitle: "다시 풀기", rightTitle: "문제 공유하기"),
                        leftAction: {
                            solveQuizNavigator.popToroot()
                        },
                        rightAction: {
                            guard let quizId = model.quizId else { return }
                            resultLink(id: quizId)
                        }
                    )))
                    .background(Color.designSystem(.g9))
                    .background(
                        ActivityView(
                            isPresented: $isSharePresented,
                            activityItems: activityItem
                        )
                    )
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
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

    private func descriptionView(me: String, friend: String, description: String) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(me) & \(friend)")
                .foregroundColor(Color.designSystem(.g4))
                .font(.pretendard(.regular, size: ._18))
                .frame(height: 26)

            Text(description)
                .foregroundColor(Color.designSystem(.g1))
                .font(.pretendard(.bold, size: ._28))
                .frame(height: 38)
        }
    }

    private func rankingView() -> some View {
        VStack(spacing: .zero) {
            if let ranking = model.result?.ranking, ranking.count >= 3 {
                Rectangle()
                    .fill(Color.designSystem(.g9))
                    .frame(height: 8)
                
                ForEach(.constant(ranking), id: \.rank) { user in
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
                    solveQuizNavigator.popToroot()
                    mainNavigator.dismissQuiz()
                }
        }
        .frame(height: 56)
        .background(Color.clear)
    }
    
    private func resultLink(id: Int) {
        DynamicLinks.makeDynamicLink(type: .solve(id: id)) {
            guard let url = $0 else { return }
            activityItem = [url]
            isSharePresented = true
        }
    }
}
