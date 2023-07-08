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
    @Binding var questionGroup: QuestionGroup
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
                            onRemove?(questionGroup.id)
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
            ForEach(questionGroup.questions) { question in
                VStack {
                    answerList(question: question, questionsCount: questionGroup.questions.count)
                }
                .padding()
                .background(Color.designSystem(.g8))
                .cornerRadius(16)
            }
        }
        .listStyle(.plain)
    }
    
    private struct answerList: View {
        
        var question: Question
        var questionsCount: Int
        @State var isTapped: Bool = false
        
        var body: some View {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    HStack {
                        Text("\(question.num). \(question.title)")
                            .font(.pretendard(.medium, size: ._18))
                            .foregroundColor(.designSystem(.g2))
                    }
                    ForEach(question.content.indices) { index in
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                AnswerPercentView(index: index, isHidden: $isTapped)
                                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                                AnswerListRow(index: index, contents: question.content[index], percent: 10)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                            }
                            .background(Color.designSystem(.g9))
                            .cornerRadius(16)
                        }
                        .frame(height: 56)
                    }
                    HStack {
                        Text("\(question.num)/\(questionsCount)")
                        Spacer()
                        Button(action: {
                            
                        }) {
                            HStack {
                                Text("눌러서 결과보기")
                                    .font(.pretendard(.medium, size: ._14))
                                    .foregroundColor(.designSystem(.g2))
                                Image(Icon.Chevron.rightMedium)
                            }
                        }
                    }
                }
                .onTapGesture {
                    self.isTapped.toggle()
                }
            }
        }
    }
}


struct QuestionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionDetail(questionGroup: .constant(questionsSamlple[0]))
    }
}

