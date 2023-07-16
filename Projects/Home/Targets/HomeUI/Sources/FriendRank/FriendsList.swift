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
    @Binding var friends: [Friend]
    
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
            LazyVStack {
                ForEach($friends) { friend in
                    FriendsRow(friend: friend)
                }
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList(friends: .constant(friendsRankSample))
    }
}
