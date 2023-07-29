//
//  QuestionDetailViewModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit
import Combine

public class QuestionDetailViewModel: ObservableObject {
    @Published var detailQuizInfo: QuizInfoViewModel = QuizInfoViewModel(quizId: 0, quizTitle: "", questions: [])
    
    private var cancellables = Set<AnyCancellable>()
    private var service: HomeService
    
    public init(quizId: Int, service: HomeService) {
        self.service = service
        
        getQuestionStatistic(QuestionStatisticRequestModel(quizId: quizId))
    }
    
    public func getQuestionStatistic(_ request: QuestionStatisticRequestModel) {
        self.service.getQuestionDetail(QuizInfoModel.self, HomeAPI.getQuestionStatistic(request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                
                var questionViewModel: [QuestionViewModel] = []
                for (index, content) in value.questions.enumerated() {
                    var answerViewModel: [AnswerViewModel] = []
                    for (index, content) in content.options.enumerated() {
                        answerViewModel.append(AnswerViewModel(optionId: content.optionId, content: content.content, isCorrect: content.isCorrect, selectivity: content.selectivity, rank: (index+1)))
                    }
                    questionViewModel.append(QuestionViewModel(questionId: content.questionId, questionTitle: content.questionTitle, rank: (index+1), options: answerViewModel))
                }
                self?.detailQuizInfo = QuizInfoViewModel(quizId: value.quizId, quizTitle: value.quizTitle, questions: questionViewModel)
            })
            .store(in: &cancellables)
    }
    
    func deleteQuestion(_ request: QuestionDeleteRequestModel) {
        self.service.deleteQuestion(QuestionDeleteModel.self, HomeAPI.deleteQuestion(request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                print("delete 완료")
            })
            .store(in: &cancellables)
    }
}


struct QuizInfoViewModel: Identifiable {
    let quizId: Int
    let quizTitle: String
    let questions: [QuestionViewModel]
    
    var id: Int {
        return quizId
    }
}

struct QuestionViewModel: Identifiable {
    let questionId: Int
    let questionTitle: String
    let rank: Int
    let options: [AnswerViewModel]
    
    var id: Int {
        return questionId
    }
    
    public init(questionId: Int, questionTitle: String, rank: Int, options: [AnswerViewModel]) {
        self.questionId = questionId
        self.questionTitle = questionTitle
        self.rank = rank
        self.options = options
    }
}

struct AnswerViewModel: Identifiable {
    var optionId: Int
    var content: String
    var isCorrect: Bool
    var selectivity: Int
    var rank: Int
    
    var id: Int {
        return optionId
    }
    
    public init(optionId: Int, content: String, isCorrect: Bool, selectivity: Int, rank: Int) {
        self.optionId = optionId
        self.content = content
        self.isCorrect = isCorrect
        self.selectivity = selectivity
        self.rank = rank
    }
}
