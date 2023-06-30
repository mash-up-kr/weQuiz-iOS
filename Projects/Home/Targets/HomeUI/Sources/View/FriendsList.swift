//
//  FriendsList.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

struct FriendsList: View {
    @Binding var friends: [Friend]
    
    var body: some View {
        List {
            Section(header: Text("전체\(friends.count)")) {
                ForEach(friends) { friend in
                    FriendsRow(friend: friend)
                }
            }
            .headerProminence(.increased)
            .listStyle(.plain)
        }
        .navigationBarTitle("친구 랭킹")
        .preferredColorScheme(.dark)
    }
}

struct FriendsList_Previews: PreviewProvider {
    static var previews: some View {
        FriendsList(friends: .constant(friendsRankSample))
    }
}
