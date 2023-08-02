//
//  HomeInteractor.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/02.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import Foundation

protocol HomeBusinessLogic {
    func getMyInfo()
    func getFriendRank(request: HomeResult.LoadRanking.Request)
    func getQuizGroup(request: HomeResult.LoadQuizGroup.Request)
}

final class HomeInteractor: HomeBusinessLogic {
    
    private var cancellables = Set<AnyCancellable>()
    private let service: HomeService
    
    var presenter: HomePresentingLogic?
    
    public init(service: HomeService) {
        self.service = service
    }
    
    func getMyInfo() {
        self.service.getMyInfo(BaseDataResponseModel<MyInfoResponseModel>.self, HomeAPI.getMyInfo)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.presenter?.present(response: .init(result: value))
            })
            .store(in: &cancellables)
    }
    
    func getFriendRank(request: HomeResult.LoadRanking.Request) {
        self.service.getFriendRank(BaseDataResponseModel<FriendRankResponseModel>.self, HomeAPI.getFriendRank(request.request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.presenter?.present(response: .init(result: value))
            })
            .store(in: &cancellables)
    }
    
    func getQuizGroup(request: HomeResult.LoadQuizGroup.Request) {
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
                self?.presenter?.present(response: .init(result: value))
            })
            .store(in: &cancellables)
    }
}
