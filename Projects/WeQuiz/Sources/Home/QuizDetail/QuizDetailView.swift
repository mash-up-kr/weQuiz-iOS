//
//  QuestionDetailView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

protocol QuizDetailDisplayLogic {
    func displayQuizDetail(viewModel: QuizDetailResult.LoadQuizDetail.ViewModel)
    func deleteQuiz(viewModel: QuizDetailResult.DeleteQuiz.ViewModel)
}

struct QuizDetailView: View {
    
    var interactor: QuizDetailBusinessLogic?
    @ObservedObject var viewModel: QuizDetailDataStore
    
    @State private var isPresentRemoveModal: Bool = false
    @State private var removeSuccessToastModal: WQToast.Model?
    
    private let navigator: HomeNavigator
    
    public init(viewModel: QuizDetailDataStore, navigator: HomeNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    var body: some View {
        VStack {
            self.topBarView
            self.questionList
        }
        .modal(
            .init(
                message: "선택한 문제를 삭제할까요?",
                doubleButtonStyleModel: .init(
                    titles: ("아니오", "삭제"),
                    leftAction: {
                        isPresentRemoveModal = false
                    },
                    rightAction: {
                        isPresentRemoveModal = false
                        removeSuccessToastModal = .init(status: .success, text: "문제를 삭제했어요")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            interactor?.deleteQuiz(request: QuizDetailResult.DeleteQuiz.Request(deleteRequest: QuizDeleteRequestModel(quizId: viewModel.quizInfo.id)))
                        }
                    }
                )
            ),
            isPresented: $isPresentRemoveModal
        )
        .toast(model: $removeSuccessToastModal)
    }
}

extension QuizDetailView {
    private var topBarView: some View {
        
        return WQTopBar(style: .navigationWithButtons(
            .init(
                title: "",
                bttons: [
                    .init(icon: Icon.Share.fillGray, action: {
                        actionSheet()
                    })
                    ,
                    .init(icon: Icon.TrashCan.fillGray, action: {
                        isPresentRemoveModal = true
                    })
                ], action: {
                    navigator.back()
                }
            )
        ))
    }
    
    private func actionSheet() {
        guard let data = URL(string: "https://www.youtube.com/") else { return }
        let activityView = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    private var questionList: some View {
        List {
            ForEach(viewModel.quizInfo.questions) { question in
                AnswerListContainer(question: question, questionsCount: viewModel.quizInfo.questions.count, questionId: question.id)
            }
        }
        .listStyle(.plain)
    }
}

extension QuizDetailView: QuizDetailDisplayLogic {
    func displayQuizDetail(viewModel: QuizDetailResult.LoadQuizDetail.ViewModel) {
        self.viewModel.quizInfo = viewModel.quizDetail
    }
    
    func deleteQuiz(viewModel: QuizDetailResult.DeleteQuiz.ViewModel) {
        navigator.back()
    }
}
