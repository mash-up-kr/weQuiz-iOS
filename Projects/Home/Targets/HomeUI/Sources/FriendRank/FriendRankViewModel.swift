//
//  FriendRankViewModel.swift
//  HomeUI
//
//  Created by 최원석 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Combine
import SwiftUI
import HomeKit

public class FriendRankViewModel: ObservableObject {
    
    @Published var friendsRank: [RankUserModel] = []
    
    private let service: HomeService
    private var friendRankGroup = PassthroughSubject<FriendRankGroupModel, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    public init(service: HomeService) {
        self.service = service
        
        friendRankGroup
            .sink {
                var viewModel: [RankUserModel] = []
                for (index, content) in $0.rankings.enumerated() {
                    viewModel.append(RankUserModel(id: content.userInfoDto.id, name: content.userInfoDto.name, rank: (index+1), score: content.score))
                }
                self.friendsRank = viewModel
            }
            .store(in: &cancellables)
        
        getFriendRank(FriendRankRequestModel(cursorScore: nil, cursorUserId: nil))
        
    }
    
    
    func getFriendRank(_ request: FriendRankRequestModel) {
        self.service.getFriendRank(FriendRankGroupModel.self, HomeAPI.getFriendRank(request))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let value = value else { return }
                self?.friendRankGroup.send(value)
            })
            .store(in: &cancellables)
    }
}
