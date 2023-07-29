//
//  FriendsList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import HomeKit

struct FriendsList: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: FriendRankViewModel

    private let naivgator: HomeNavigator
    
    public init(navigator: HomeNavigator, viewModel: FriendRankViewModel) {
        self.naivgator = navigator
        self.viewModel = viewModel
    }
    
    var body: some View {
        self.topBarView
        self.listView
            .navigationBarHidden(true)
    }
}

extension FriendsList {
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
                ForEach($viewModel.friendsRank) { rank in
                    FriendsRow(friend: rank)
                }
            }
            .padding(20)
        }
        .preferredColorScheme(.dark)
    }
}
