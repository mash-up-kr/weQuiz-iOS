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
    @Binding var questions: [Question]
    
    var body: some View {
        self.topBarView
        self.questionList
            .navigationBarHidden(true)
    }
}

extension QuestionDetail {
    private var topBarView: some View {
        WQTopBar(style: .navigationWithButtons(
            .init(
                title: "",
                bttons: [
                    .init(icon: Icon.Edit.list, action: {
                        print("네비게이션 버튼 클릭1")
                    }),
                    .init(icon: Icon.CircleAlert.fillMono, action: {
                        print("네비게이션 버튼 클릭2")
                    })
                ], action: {
                    dismiss()
                }
            )
        ))
    }
    
    private var questionList: some View {
        List {
            ForEach(questions) { question in
                VStack {
                    answerList(question: question)
                    HStack {
                        Text("\(question.num)/\(questions.count)")
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
                    print("aslkdnaslkdsanlkan")
                }
                .padding()
                .background(Color.designSystem(.g8))
                .cornerRadius(16)
            }
            .onDelete(perform: removeItem)
        }
        .listStyle(.plain)
    }
    
    private func removeItem(at offsets: IndexSet) {
        questions.remove(atOffsets: offsets)
    }
    
    private struct answerList: View {
        
        var question: Question
        
        var body: some View {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    HStack {
                        Text("\(question.num). \(question.title)")
                            .font(.pretendard(.medium, size: ._18))
                            .foregroundColor(.designSystem(.g2))
                    }
                    ForEach(question.content.indices) { index in
                        AnswerListRow(index: index, contents: question.content[index])
                    }
                    
//                    ForEach(question.content, id: \.self) { content in
//                        AnswerListRow(index: 1, contents: content)
//                    }
                }
            }
        }
    }
}

struct QuestionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionDetail(questions: .constant(questionsSamlple[0].questions))
    }
}

