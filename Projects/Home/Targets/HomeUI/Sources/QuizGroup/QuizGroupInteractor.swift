//
//  QuestionGroupInteractor.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import HomeKit
import Combine
import CoreKit

protocol QuizGroupBusinessLogic {
    func getQuizGroup(request: QuizGroupResult.LoadQuizGroup.Request)
    func deleteQuiz(request: QuizGroupResult.DeleteQuiz.Request)
}

final class QuizGroupInteractor: QuizGroupBusinessLogic {
    
    private var cancellables = Set<AnyCancellable>()
    private let service: HomeService
    
    var presenter: QuizGroupPresentingLogic?
    
    public init(service: HomeService) {
        self.service = service
    }
    
    func getQuizGroup(request: QuizGroupResult.LoadQuizGroup.Request) {
        self.service.getQuizGroup(BaseDataResponseModel<QuizGroupResponseModel>.self, HomeAPI.getQuizGroup(request.quizGroupRequest))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.presenter?.present(response: .init(quizGroupResponse: value))
            })
            .store(in: &cancellables)
    }
    
    func deleteQuiz(request: QuizGroupResult.DeleteQuiz.Request) {
        self.service.deleteQuiz(BaseDataResponseModel<QuizDeleteResponseModel>.self, HomeAPI.deleteQuiz(request.deleteRequest))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.getQuizGroup(request: QuizGroupResult.LoadQuizGroup.Request(quizGroupRequest: QuizGroupRequestModel(size: 15, cursor: nil)))
            })
            .store(in: &cancellables)
    }
}
