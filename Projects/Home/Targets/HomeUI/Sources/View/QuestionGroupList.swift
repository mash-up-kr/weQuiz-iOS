//
//  QuestionsList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct QuestionGroupList: View {
    @Binding var questions: [QuestionGroup]
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: ListHeader(questions: $questions, isEditing: $isEditing)) {
                    ForEach(questions) { question in
                        QuestionGroupRow(questionGroup: question)
                    }
                    .onDelete(perform: deleteItems)
                    .headerProminence(.increased)
                    .listStyle(.plain)
                }
            }
            .animation(.default)
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
        }
        .navigationBarTitle("문제 리스트")
        .preferredColorScheme(.dark)
    }
    
    func deleteItems(at offsets: IndexSet) {
        questions.remove(atOffsets: offsets)
    }
}

extension QuestionGroupList {
    private struct ListHeader: View {
        @Binding var questions: [QuestionGroup]
        @Binding var isEditing: Bool
        
        var body: some View {
            HStack {
                Text("전체\(questions.count)")
                    .font(.system(size: 14))
                    .font(.title)
                Spacer()
                CustomEditButton(isEditing: $isEditing)
            }
        }
    }

    private struct CustomEditButton: View {
        @Binding var isEditing: Bool
        
        private var title: String {
            return isEditing ? "삭제" : "편집"
        }
        
        var body: some View {
            Button(action: {
                isEditing.toggle()
            }) {
                Text(title)
                    .font(.system(size: 14))
            }
            .animation(.default)
        }
    }
}

struct QuestionGroupList_Previews: PreviewProvider {
    static var previews: some View {
        QuestionGroupList(questions: .constant(questionsSamlple))
    }
}
