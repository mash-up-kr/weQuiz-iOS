//
//  QuestionsList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import HomeKit
import CoreKit

protocol QuizGroupDisplayLogic {
    func displayQuizGroup(viewModel: QuizGroupResult.LoadQuizGroup.ViewModel)
    func deleteQuiz(viewModel: QuizGroupResult.DeleteQuiz.ViewModel)
}

struct QuizGroupView: View {
    
    var interactor: QuizGroupBusinessLogic?
    
    @ObservedObject var viewModel: QuizGroupDataStore
    @State private var isEdited = false
    
    private let naivgator: HomeNavigator
    
    public init(naivgator: HomeNavigator, viewModel: QuizGroupDataStore) {
        self.naivgator = naivgator
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            self.topBarView
            self.listBarView
            self.listView
        }
        .task {
            interactor?.getQuizGroup(request: QuizGroupResult.LoadQuizGroup.Request(quizGroupRequest: QuizGroupRequestModel(size: 15, cursor: nil)))
        }
    }
    
    private var topBarView: some View {
        WQTopBar(style: .navigation(
            .init(
                title: "문제 리스트",
                action: {
                    naivgator.back()
                })))
    }
    
    private var listBarView: some View {
        HStack {
            Text("전체\(viewModel.quizs.count)")
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.medium, size: ._14))
                .padding([.horizontal, .top], 20)
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
            }
        }
    }
    
    private var listView: some View {
        List {
            ForEach($viewModel.quizs) { quiz in
                ZStack {
                    QuizGroupRow(quiz: quiz)
                }
                .onTapGesture {
                    naivgator.path.append(.questionDetail(quizId: quiz.id))
                }
                .listRowBackground(Color.clear)
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
        if let firstIndex = offsets.first {
            interactor?.deleteQuiz(request: QuizGroupResult.DeleteQuiz.Request(deleteRequest: QuizDeleteRequestModel(quizId: viewModel.quizs[firstIndex].id)))
        }
    }
}

extension QuizGroupView: QuizGroupDisplayLogic {
    func displayQuizGroup(viewModel: QuizGroupResult.LoadQuizGroup.ViewModel) {
        self.viewModel.quizs = viewModel.quizs
    }
    
    func deleteQuiz(viewModel: QuizGroupResult.DeleteQuiz.ViewModel) {
        print("delete 완료시 이뤄지는 이벤트 명시")
    }
}
