//
//  QuestionsList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct QuestionGroupList: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var questions: [QuestionGroup]
    @State private var isEdited = false
    
    var body: some View {
        self.topBarView
        self.listBarView
        self.listView
            .navigationBarHidden(true)
    }
}

extension QuestionGroupList {
    private var topBarView: some View {
        WQTopBar(style: .navigation(
            .init(
                title: "문제 리스트",
                action: {
                    dismiss()
                })))
    }
    
    private var listBarView: some View {
        HStack {
            Text("전체\(questions.count)")
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.medium, size: ._14))
                .padding([.horizontal, .top], 20)
                .padding(.bottom, 16)
            Spacer()
            Button(action: {
                withAnimation {
                    self.isEdited.toggle()
                }
            }) {
                Text(isEdited ? "완료" : "편집")
                    .foregroundColor(.designSystem(.g2))
                    .font(.pretendard(.regular, size: ._14))
                    .padding([.horizontal, .top], 20)
                    .padding(.bottom, 16)
            }
        }
    }
    
    private var listView: some View {
        List {
            ForEach($questions) { question in
                QuestionGroupRow(
                    questionGroup: question
                )
                .padding(.horizontal, 20)
                .listRowInsets(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: removeItem)
        }
        .environment(\.editMode, .constant(isEdited ? EditMode.active : EditMode.inactive))
        .listStyle(.plain)
    }
    
    private func removeItem(at offsets: IndexSet) {
        questions.remove(atOffsets: offsets)
    }
}

struct QuestionGroupList_Previews: PreviewProvider {
    static var previews: some View {
        QuestionGroupList(questions: .constant(questionsSamlple))
    }
}
