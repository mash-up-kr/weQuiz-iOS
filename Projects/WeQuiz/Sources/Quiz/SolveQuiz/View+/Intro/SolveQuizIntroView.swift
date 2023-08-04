//
//  SolveQuizIntroView.swift
//  QuizUI
//
//  Created by AhnSangHoon on 2023/07/03.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct SolveQuizIntroView: View {
    @EnvironmentObject var mainNavigator: MainNavigator
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    
    private let quizId: Int
    @ObservedObject var viewModel: SolveQuizIntroViewModel = .init()
    
    init(quizId: Int) {
        self.quizId = quizId
        self.viewModel.loadQuiz(id: quizId)
    }
    
    public var body: some View {
        NavigationStack(path: $solveQuizNavigator.path) {
            ZStack(alignment: .topTrailing) {
                Image(Icon.Home.fillGray)
                    .tint(.white)
                    .padding(.top, 16)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        mainNavigator.showQuiz = false
                    }
                VStack {
                    VStack(spacing: .zero) {
                        quizNumber(10)
                        title("출제자")
                        Spacer()
                        name()
                        Spacer()
                            .frame(height: 30)
                        thumbnail()
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    WQButton(style: .single(
                        .init(
                            title: "시험 응시하기",
                            action: {
                                solveQuizNavigator.path.append(.input(quizId))
                            }
                        )
                    ))
                }
            }
            .background(
                Image("quiz_solve_background")
            )
            .navigationDestination(for: SolveQuizScreen.self) { screen in
                switch screen {
                case .input(let id):
                    SolveQuizUserNameInputView(quizId: id)
                case .solve(let id):
                    SolveQuizView(quizId: id).configureView()
                }
            }
        }
    }
    
    private func quizNumber(_ number: Int) -> some View {
        ZStack(alignment: .leading) {
            Color.clear
                .frame(height: 32)
            HStack {
                Text("제 \(number)회")
                    .font(.pretendard(.bold, size: ._14))
                    .foregroundColor(.designSystem(.g4))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.designSystem(.g6))
                    .cornerRadius(16)
            }
        }
        .padding(.top, 46)
    }
    
    private func title(_ examiner: String) -> some View {
        VStack(spacing: 10) {
            Text(viewModel.quizModel.quiz.title)
                .font(.pretendard(.medium, size: ._20))
                .foregroundColor(.designSystem(.g4))
            VStack(spacing: .zero) {
                Text(examiner)
                    .font(.pretendard(.bold, size: ._34))
                    .foregroundColor(.designSystem(.g1))
                Text("영역")
                    .font(.pretendard(.bold, size: ._28))
                    .foregroundColor(.designSystem(.g4))
            }
        }
    }
    
    private func name() -> some View {
        Color.designSystem(.g3)
            .frame(height: 36)
    }
    
    private func thumbnail() -> some View {
        Image("quiz_solve_thumbnail")
    }
}
