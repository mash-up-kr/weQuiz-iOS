//
//  FriendsList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

protocol FriendRankDisplayLogic {
    func displayRanking(viewModel: FriendRankResult.LoadRanking.ViewModel)
}

struct FriendRankView: View {
    
    var interactor: FriendRankBusinessLogic?
    
    @ObservedObject var viewModel: FriendRankDataStore
    @Environment(\.dismiss) private var dismiss
    
    private let naivgator: HomeNavigator
    
    public init(
        navigator: HomeNavigator,
        viewModel: FriendRankDataStore
    ) {
        self.naivgator = navigator
        self.viewModel = viewModel
    }
    
    var body: some View {
        self.topBarView
        self.listView
            .navigationBarHidden(true)
    }
}

extension FriendRankView {
    private var topBarView: some View {
        let title = "친구 랭킹"
        
        return WQTopBar(style: .navigation(
            .init(
                title: title,
                action: {
                    naivgator.back()
                })))
    }
    
    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach($viewModel.result) { rank in
                    FriendRankRow(friend: rank)
                }
            }
            .padding(20)
        }
        .preferredColorScheme(.dark)
    }
}

extension FriendRankView: FriendRankDisplayLogic {
    func displayRanking(viewModel: FriendRankResult.LoadRanking.ViewModel) {
        self.viewModel.result = viewModel.rank
    }
}
