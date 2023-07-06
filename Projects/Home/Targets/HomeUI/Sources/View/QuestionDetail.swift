//
//  QuestionDetailView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import QuizUI

struct QuestionDetail: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var questions: [Question]
    @State var isTapedList: Bool = false
    
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
                        actionSheet()
                    })
                    ,
                    .init(icon: Icon.CircleAlert.fillMono, action: {
                        // 휴지통 로직을 구현해줘야 한다.
                        // 휴지통 버튼을 클릭하면 Question 전체가 없어져야 하므로 이는 이전 VC에서 질문을 삭제해줘야한다.
                        // 이것은 즉 Rounter가 필요할 것 같다.
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
            ForEach(questions) { question in
                VStack {
                    answerList(question: question, isTapedList: $isTapedList)
                    QuestionBottonBar(question: question, questionsCount: questions.count)
                }
                .onTapGesture {
                    self.isTapedList.toggle()
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
        @Binding var isTapedList: Bool
        
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
                                AnswerPercentView(index: index, isHidden: $isTapedList)
                                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                                AnswerListRow(index: index, contents: question.content[index], percent: 10)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                            }
                            .background(Color.designSystem(.g9))
                            .cornerRadius(16)
                        }
                        .frame(height: 56)
                    }
                }
            }
        }
    }
    
    private struct QuestionBottonBar: View {
        
        var question: Question
        var questionsCount: Int
        
        var body: some View {
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
    }
}


struct QuestionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionDetail(questions: .constant(questionsSamlple[0].questions))
    }
}

