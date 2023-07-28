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
    
    @Environment(\.dismiss) private var dismiss
    @Binding var quizInfo: QuizInfoModel
    @Binding var quizStatistic: [QuestionStatisticModel]
    @Binding var quizDetail: QuestionDetailModel
    @State private var isPresentRemoveModal: Bool = false
    @State private var removeSuccessToastModal: WQToast.Model?
    var onRemove: ((Int) -> ())?
    
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
                            onRemove?(quizInfo.id)
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
                    .init(icon: Icon.Edit.list, action: {
                        actionSheet()
                    })
                    ,
                    .init(icon: Icon.CircleAlert.fillMono, action: {
                        isPresentRemoveModal = true
                    })
                ], action: {
                    dismiss()
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
        return EmptyView()
//        List {
//            ForEach(quizInfo.questions.indices) { index in
//                AnswerListContainer(questionDetail: quizDetail, question: quizInfo.questions[index], questionStatistic: quizStatistic[index], questionsCount: quizInfo.questions.count)
//            }
//        }
//        .listStyle(.plain)
        
//        List {
//            ForEach(quizInfo.questions.indices) { index in
//                AnswerListContainer(question: quizInfo.questions[index], questionStatistic: quizStatistic[index], questionsCount: quizInfo.questions.count)
//            }
//        }
//        .listStyle(.plain)
    }
}


//struct QuestionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionDetail(quizInfo: .constant(questionDetailSample.quizInfo), quizStatistic: .constant(questionDetailSample.statistic))
//    }
//}

