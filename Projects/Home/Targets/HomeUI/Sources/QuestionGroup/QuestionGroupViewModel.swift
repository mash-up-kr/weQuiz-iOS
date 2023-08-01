//
//  QuestionGroupViewModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import HomeKit
import Combine

public class QuestionGroupViewModel: ObservableObject {
    
    @Published var questions: [SummaryQuestionModel] = []
    
    private var service: HomeService
    private var cancellables = Set<AnyCancellable>()
    
    public init(service: HomeService, questions: [SummaryQuestionModel]) {
        self.service = service
        self.questions = questions
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
