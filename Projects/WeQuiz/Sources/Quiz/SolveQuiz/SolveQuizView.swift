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
    func displayErrorMessage(viewModel: SolveQuiz.LoadQuizResult.ViewModel.ErrorMessage)
}

public struct SolveQuizView: View {
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    @ObservedObject var viewModel: SolveQuizDataStore
    @State private var _showReportModal: Bool = false
    @State private var _reportedToastModel: WQToast.Model?
    @State private var errorMessageToastModel: WQToast.Model?
    
    let quizId: Int
    var interactor: SolveQuizBusinessLogic?
    private let solver: SolveQuizUser
    
    init(
        quizId: Int,
        _ viewModel: SolveQuizDataStore,
        solver: SolveQuizUser
    ) {
        self.quizId = quizId
        self.viewModel = viewModel
        self.solver = solver
    }

    public var body: some View {
        ZStack {
            if viewModel.solvedQuiz.questions.count > 0 {
                VStack(spacing: .zero) {
                    WQTopBar(
                        style: .navigationWithButtons(.init(
                            title: "",
                            bttons: [
                                .init(
                                    icon: Icon.Siren.mono,
                                    action: {
                                        _showReportModal = true
                                    }
                                )
                            ],
                            action: {
                                viewModel.selectedCount = 0
                                
                                if viewModel.goToPreviousQuestion() == false {
                                    solveQuizNavigator.back()
                                }
                            }
                        ))
                    )
                    
                    WQGradientProgressBar(
                        standard: viewModel.solvedQuiz.questions.count,
                        current: .constant(viewModel.currentIndex + 1)
                    )

                    tooltip()
                        .padding(.top, 28)

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

                    ForEach($viewModel.solvedQuiz.questions[viewModel.currentIndex].answers.indices, id: \.self) { answerIndex in
                        let answer = $viewModel.solvedQuiz.questions[viewModel.currentIndex].answers[answerIndex]
                        SolveQuizAnswerView(answer, answerIndex)
                            .onTapGesture {
                                answer.isSelected.wrappedValue.toggle()
                            }
                            .onChange(of: answer.isSelected.wrappedValue, perform: { isSelected in
                                if isSelected {
                                    viewModel.selectedCount += 1
                                } else if viewModel.selectedCount - 1 >= 0 {
                                    viewModel.selectedCount -= 1
                                } else {
                                    return
                                }
                                if viewModel.selectedCount == viewModel.solvedQuiz.questions[viewModel.currentIndex].answerCount {
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
                viewModel.selectedCount = 0
            }
        ) {
            if let quizResult = viewModel.quizResult {
                QuizResultView(quizId: quizId, quizResult).configureView()
            }
        }
        .onChange(of: viewModel.errorMessage, perform: { model in
            errorMessageToastModel = .init(status: .warning, text: model.message)
        })
        .toast(model: $_reportedToastModel)
        .toast(model: $errorMessageToastModel)
        .modal(
            .init(
                message: "문제를 신고할까요?",
                doubleButtonStyleModel: WQButton.Style.DobuleButtonStyleModel(
                    titles: ("아니요", rightTitle: "신고"),
                    leftAction: {
                        _showReportModal = false
                    },
                    rightAction: {
                        _showReportModal = false
                        _reportedToastModel = .init(status: .success, text: "문제 신고가 완료되었습니다")
                    }
                )
            ),
            isPresented: $_showReportModal
        )
        .navigationBarBackButtonHidden()
    }

    private func onNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            if viewModel.currentIndex + 1 < viewModel.solvedQuiz.questions.count {
                viewModel.currentIndex += 1
                viewModel.selectedCount = 0
            } else {
                switch solver {
                case .user:
                    interactor?.requestQuizResult(
                        request: .init(quizId: self.quizId, quiz: viewModel.solvedQuiz)
                    )
                case .nonUser(let token):
                    interactor?.requestQuizResultForAnonymous(
                        request: .init(quizId: self.quizId, quiz: viewModel.solvedQuiz),
                        temporaryToken: token
                    )
                }
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
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.designSystem(.g8))
            )
    }
}

extension SolveQuizView: SolveQuizDisplayLogic {
    func displayQuizResult(viewModel: SolveQuiz.LoadQuizResult.ViewModel) {
        self.viewModel.quizResult = viewModel.result
        self.viewModel.routeToResultView = true
    }
    
    func displayErrorMessage(viewModel: SolveQuiz.LoadQuizResult.ViewModel.ErrorMessage) {
        self.viewModel.errorMessage = .init(message: viewModel.message)
    }
}
