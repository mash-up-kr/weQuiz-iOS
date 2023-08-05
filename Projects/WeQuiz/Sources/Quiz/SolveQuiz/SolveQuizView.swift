//
//  SolveQuizView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import SwiftUI

import DesignSystemKit

protocol SolveQuizDisplayLogic {
    func displayQuizResult(viewModel: SolveQuiz.LoadQuizResult.ViewModel)
}

public struct SolveQuizView: View {
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    @ObservedObject var viewModel: SolveQuizDataStore
    @State var selectedCount: Int = 0
    
    let quizId: Int
    var interactor: SolveQuizBusinessLogic?
    
    init(quizId: Int, _ viewModel: SolveQuizDataStore) {
        self.quizId = quizId
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            if viewModel.solvedQuiz.questions.count > 0 {
                VStack {
                    WQTopBar(style: .navigationWithButtons(
                        .init(title: "",
                              bttons: [
                                .init(icon: Icon.Siren.mono, action: {
                            print("신고하기 버튼 클릭")
                        })], action: {
                            self.selectedCount = 0
                            
                            if viewModel.goToPreviousQuestion() == false {
                                solveQuizNavigator.back()
                            }
                        })
                    ))

                    WQGradientProgressBar(
                        standard: viewModel.solvedQuiz.questions.count,
                        current: .constant(viewModel.currentIndex + 1)
                    )

                    tooltip()

                    Spacer()
                }
                .background(Color.designSystem(.g9))

                VStack(alignment: .center) {
                    
                    HStack(spacing: 10) {
                        Text("\(viewModel.currentIndex + 1)")
                            .font(.pretendard(.bold, size: ._20))
                            .foregroundColor(Color.designSystem(.g1))
                            .frame(alignment: .leading)
                            .frame(height: 26)
                        scoreView()
                        Spacer()
                    }

                    Text(viewModel.solvedQuiz.questions[viewModel.currentIndex].title)
                        .font(.pretendard(.medium, size: ._24))
                        .foregroundColor(Color.designSystem(.g1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 34)
                    Text("답 \(viewModel.solvedQuiz.questions[viewModel.currentIndex].answerCount)개")
                        .font(.pretendard(.bold, size: ._16))
                        .foregroundStyle(
                            DesignSystemKit.Gradient.gradientS1.linearGradient
                        )
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 24)

                    ForEach($viewModel.solvedQuiz.questions[viewModel.currentIndex].answers, id: \.id) { answer in
                        SolveQuizAnswerView(answer)
                            .onTapGesture {
                                answer.isSelected.wrappedValue.toggle()
                            }
                            .onChange(of: answer.isSelected.wrappedValue, perform: { isSelected in
                                selectedCount = (isSelected == true) ? selectedCount + 1 : selectedCount - 1
                                if selectedCount == viewModel.solvedQuiz.questions[viewModel.currentIndex].answerCount {
                                    onNextQuestion()
                                }
                            })
                    }

                }
                .padding(.horizontal, 20)
            }
        }
        .fullScreenCover(
            isPresented: $viewModel.routeToResultView,
            onDismiss: {
                viewModel.resetQuiz()
                self.selectedCount = 0
            }
        ) {
            if let quizResult = viewModel.quizResult {
                QuizResultView(quizId: quizId, quizResult).configureView()
            }
        }
        .navigationBarBackButtonHidden()
    }

    private func onNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            if viewModel.currentIndex + 1 < viewModel.solvedQuiz.questions.count {
                viewModel.currentIndex += 1
                selectedCount = 0
            } else {
                interactor?.requestQuizResult(request: .init(quizId: self.quizId, quiz: viewModel.solvedQuiz))
            }
        }
    }

    private func tooltip() -> some View {
        Text("\(viewModel.solvedQuiz.questions.count)문제 중 \(viewModel.currentIndex + 1)번째 문제")
            .font(.pretendard(.bold, size: ._14))
            .foregroundColor(.designSystem(.g4))
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color.designSystem(.g8))
            .cornerRadius(16)
            .frame(height: 32)
    }
    
    private func scoreView() -> some View {
        Text("\(viewModel.solvedQuiz.questions[viewModel.currentIndex].score)점")
            .font(.pretendard(.medium, size: ._14))
            .foregroundColor(.designSystem(.g4))
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.designSystem(.g8))
    }
}

extension SolveQuizView: SolveQuizDisplayLogic {
    func displayQuizResult(viewModel: SolveQuiz.LoadQuizResult.ViewModel) {
        self.viewModel.quizResult = viewModel.result
        self.viewModel.routeToResultView = true
    }
}
