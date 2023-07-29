//
//  QuestionDetailView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import HomeKit

struct QuestionDetail: View {
    
    @ObservedObject var viewModel: QuestionDetailViewModel
    @State private var isPresentRemoveModal: Bool = false
    @State private var removeSuccessToastModal: WQToast.Model?
    
    private let navigator: HomeNavigator
    
    public init(viewModel: QuestionDetailViewModel, navigator: HomeNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    var body: some View {
        VStack {
            self.topBarView
            self.questionList
        }
        .navigationBarHidden(true)
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
                            viewModel.deleteQuestion(QuestionDeleteRequestModel(quizId: viewModel.detailQuizInfo.id))
                            navigator.back()
                        }
                    }
                )
            ),
            isPresented: $isPresentRemoveModal
        )
        .toast(model: $removeSuccessToastModal)
    }
}

extension QuestionDetail {
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
            ForEach(viewModel.detailQuizInfo.questions) { question in
                AnswerListContainer(question: question, questionsCount: viewModel.detailQuizInfo.questions.count, questionId: question.id)
            }
        }
        .listStyle(.plain)
    }
}

//struct QuestionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionDetail(quizInfo: .constant(questionDetailSample.quizInfo), quizStatistic: .constant(questionDetailSample.statistic))
//    }
//}
