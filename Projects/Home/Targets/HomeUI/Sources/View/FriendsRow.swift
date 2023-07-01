//
//  FriendsRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

struct FriendsRow: View {
    let friend: Friend
    
    var body: some View {
        self.friendInfoDescription
    }
}

extension FriendsRow {
    private var friendInfoDescription: some View {
        HStack {
            image
                .padding(.vertical, 16)
                .padding(.leading, 16)
            Text(self.friend.name)
                .padding(.vertical, 16)
            Text("#" + self.friend.originalNum)
                .padding(.all, 4)
                .foregroundColor(.designSystem(.g1))
                .background(.black)
                .cornerRadius(4)
            Spacer()
            Text("\(self.friend.Score)점")
                .padding(.trailing, 16)
                .padding(.vertical, 16)
                .foregroundColor(.designSystem(.g1))
        }
        .frame(height: 56)
        .background(Color.designSystem(.g8))
        .cornerRadius(16)
    }
    
    private var image: some View {
        switch friend.rank {
        case 1: return Image(systemName: "circle")
        case 2: return Image(systemName: "triangle")
        case 3: return Image(systemName: "square")
        default: return Image(systemName: "circle.fill")
        }
    }
}

