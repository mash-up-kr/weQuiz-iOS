//
//  QuestionDetailView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct QuestionDetail: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var questionDetail: QuestionDetailModel
    @State private var isPresentRemoveModal: Bool = false
    @State private var removeSuccessToastModal: WQToast.Model?
    var onRemove: ((UUID) -> ())?
    
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
                            onRemove?(questionDetail.id)
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
        WQTopBar(style: .navigationWithButtons(
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
        List {
            ForEach(questionDetail.questions) { question in
                AnswerListContainer(question: question, questionsCount: questionDetail.questions.count)
            }
        }
        .listStyle(.plain)
    }
}


struct QuestionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionDetail(questionDetail: .constant(questionDetailSample))
    }
}

