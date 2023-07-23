//
//  FriendsList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit


struct FriendsList: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var friends: [FriendModel]
    
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
                dismiss()
            })))
    }
    
    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(friends.indices) { index in
                    FriendsRow(friend: $friends[index], priority: index+1)
                }
            }
            .padding(20)
        }
        .preferredColorScheme(.dark)
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList(friends: .constant(friendsRankSample.rankings))
    }
}
