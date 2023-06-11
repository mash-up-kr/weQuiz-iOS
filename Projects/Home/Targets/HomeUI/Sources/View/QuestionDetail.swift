//
//  QuestionDetailView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct QuestionDetail: View {
    
    var questionGroup: QuestionGroup
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Text("기본 설명문은 여기에 적어준다.")
                    .font(.system(size: 24))
                    .padding(.bottom)
                
                ForEach(questionGroup.questions, id: \.id) { question in
                    questionsList(question: question)
                }
                .padding()
            }
            .navigationBarItems(
                leading: Button(action: {
                    // 왼쪽 아이템 동작
                    print("Leading Item Tapped")
                }) {
                    Image(systemName: "gear")
                },
                trailing: Button(action: {
                    // 오른쪽 아이템 동작
                    print("Trailing Item Tapped")
                }) {
                    Image(systemName: "plus")
                }
            )
            .preferredColorScheme(.dark)
        }
    }
}

struct questionsList: View {
    var question: Question
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(question.title)
                    .font(.system(size: 24))
                    .padding(.bottom)
                ForEach(question.content, id: \.self) { content in
                    QuestionDetailRow(contents: content)
                }
            }
        }
    }
}

//struct QuestionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionDetail(questionGroup: )
//    }
//}

