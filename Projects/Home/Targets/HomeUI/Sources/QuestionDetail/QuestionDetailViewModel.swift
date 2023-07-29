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
    @Published var detailQuizInfo: QuizInfoModel = QuizInfoModel(quizId: 0, quizTitle: "", questions: [])
    
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
                self?.detailQuizInfo = value
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
