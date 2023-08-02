//
//  QuizDetailInteractor.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation
import Combine
import CoreKit
import HomeKit

protocol QuizDetailBusinessLogic {
    func getQuizDetail(request: QuizDetailResult.LoadQuizDetail.Request)
    func deleteQuiz(request: QuizDetailResult.DeleteQuiz.Request)
}

final class QuizDetailInteractor: QuizDetailBusinessLogic {
    
    private var cancellables = Set<AnyCancellable>()
    private let service: HomeService
    
    var presenter: QuizDetailPresentingLogic?
    
    public init(service: HomeService) {
        self.service = service
    }
    
    func getQuizDetail(request: QuizDetailResult.LoadQuizDetail.Request) {
        self.service.getQuizDetail(BaseDataResponseModel<QuizDetailResponseModel>.self, HomeAPI.getQuizDetail(request.quizDetailRequest))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.presenter?.present(response: .init(quizDetailResponse: value))
            })
            .store(in: &cancellables)
    }
    
    func deleteQuiz(request: QuizDetailResult.DeleteQuiz.Request) {
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
                self?.presenter?.present(response: .init(deleteResponse: value))
            })
            .store(in: &cancellables)
    }
}
