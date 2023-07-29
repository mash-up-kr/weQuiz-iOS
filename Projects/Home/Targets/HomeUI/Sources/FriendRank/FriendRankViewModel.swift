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
    
    public static let `default`: FriendRankViewModel = .init(service: HomeService())
    
    @Published var friendsRank: [FriendModel] = []
    
    private let service: HomeService
    private var cancellables = Set<AnyCancellable>()
    
    public init(service: HomeService) {
        self.service = service
        
        getFriendRank(FriendRankRequestModel(quizAnswerCursorId: nil))
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
                self?.friendsRank = value.rankings
            })
            .store(in: &cancellables)
    }
}
