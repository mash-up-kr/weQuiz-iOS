//
//  SolveQuizView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//
import SwiftUI
import DesignSystemKit
import QuizKit

protocol SolveQuizDisplayLogic {
    func displayQuiz(viewModel: SolveQuiz.LoadSolveQuiz.ViewModel)
    func displayQuizResult(viewModel: SolveQuiz.LoadQuizResult.ViewModel)
}

public struct SolveQuizView: View {
    var interactor: SolveQuizBusinessLogic?
    
    @ObservedObject var viewModel = SolveQuizDataStore()
    @State var currentIndex: Int = 0
    @State var selectedCount: Int = 0
    public let quizId: Int
    
    public init(quizId: Int) {
        self.quizId = quizId
    }

    public var body: some View {
        ZStack {
            if viewModel.quiz.questions.count > 0 {
                VStack {
                    WQTopBar(style: .navigationWithButtons(
                        .init(title: "",
                              bttons: [
                                .init(icon: Icon.Siren.mono, action: {
                            print("신고하기 버튼 클릭")
                        })
                        ])
                    ))

                    WQGradientProgressBar(
                        standard: viewModel.quiz.questions.count,
                        current: .constant(currentIndex + 1)
                    )

                    tooltip()

                    Spacer()
                }
                .background(Color.designSystem(.g9))

                VStack(alignment: .center) {
                    
                    HStack(spacing: 10) {
                        Text("\(currentIndex + 1)")
                            .font(.pretendard(.bold, size: ._20))
                            .foregroundColor(Color.designSystem(.g1))
                            .frame(alignment: .leading)
                            .frame(height: 26)
                        scoreView()
                        Spacer()
                    }

                    
                    Text(viewModel.quiz.questions[currentIndex].title)
                        .font(.pretendard(.medium, size: ._24))
                        .foregroundColor(Color.designSystem(.g1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 34)
                    Text("답 \(viewModel.quiz.questions[currentIndex].answerCount)개")
                        .font(.pretendard(.bold, size: ._16))
                        .foregroundStyle(
                            DesignSystemKit.Gradient.gradientS1.linearGradient
                        )
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 24)

                    ForEach($viewModel.quiz.questions[currentIndex].answers, id: \.id) { answer in
                        SolveQuizAnswerView(answer)
                            .onChange(of: answer.isSelected.wrappedValue, perform: { isSelected in
                                selectedCount = (isSelected == true) ? selectedCount + 1 : selectedCount - 1
                                if selectedCount == viewModel.quiz.questions[currentIndex].answerCount {
                                    onNextQuestion()
                                }
                            })
                    }

                }
                .padding(.horizontal, 20)
            }
            
        }
        .task {
            interactor?.loadQuiz(request: .init(quizId: quizId))
        }
        .fullScreenCover(isPresented: $viewModel.routeToResultView) {
            if let quizResult = viewModel.quizResult {
                QuizResultView(quizResult)
            }
        }
    }

    private func onNextQuestion() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            if currentIndex + 1 < viewModel.quiz.questions.count {
                currentIndex += 1
                selectedCount = 0
            } else {
                interactor?.requestQuizResult(request: .init(quizId: self.quizId, quiz: viewModel.quiz))
            }
        }
    }

    private func tooltip() -> some View {
        Text("\(viewModel.quiz.questions.count)문제 중 \(currentIndex + 1)번째 문제")
            .font(.pretendard(.bold, size: ._14))
            .foregroundColor(.designSystem(.g4))
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color.designSystem(.g8))
            .cornerRadius(16)
            .frame(height: 32)
    }
    
    private func scoreView() -> some View {
        Text("\(viewModel.quiz.questions[currentIndex].score)점")
            .font(.pretendard(.medium, size: ._14))
            .foregroundColor(.designSystem(.g4))
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.designSystem(.g8))
    }
}

extension SolveQuizView: SolveQuizDisplayLogic {
    func displayQuiz(viewModel: SolveQuiz.LoadSolveQuiz.ViewModel) {
        self.viewModel.quiz = viewModel.quiz
    }
    
    func displayQuizResult(viewModel: SolveQuiz.LoadQuizResult.ViewModel) {
        self.viewModel.quizResult = viewModel.result
        self.viewModel.routeToResultView = true
    }
}

struct SolveQuizView_Previews: PreviewProvider {
    static var previews: some View {
        return SolveQuizView(quizId: 1)
    }
}
