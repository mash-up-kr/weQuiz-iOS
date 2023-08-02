//
//  FriendRankInteractor.swift
//  HomeUI
//
//  Created by 최원석 on 2023/08/01.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import Foundation

protocol FriendRankBusinessLogic {
    func getFriendRank(request: FriendRankResult.LoadRanking.Request)
}

final class FriendRankInteractor: FriendRankBusinessLogic {
    
    private var cancellables = Set<AnyCancellable>()
    private let service: HomeService
    
    var presenter: FriendRankPresentingLogic?
    
    public init(service: HomeService) {
        self.service = service
    }
    
    func getFriendRank(request: FriendRankResult.LoadRanking.Request) {
        self.service.getFriendRank(BaseDataResponseModel<FriendRankResponseModel>.self, HomeAPI.getFriendRank(FriendRankRequestModel(size: 15, cursorScore: nil, cursorUserId: nil)))
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
