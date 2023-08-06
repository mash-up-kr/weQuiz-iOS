//
//  FriendsRow.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct FriendRankRow: View {
    @Binding var friend: RankModel
    
    var body: some View {
        HStack {
            self.priorityImageView
            self.descriptionView
            self.uniqueNumView
            Spacer()
            self.scoreView
        }
        .frame(height: 58)
        .background(Color.designSystem(.g8))
        .cornerRadius(16)
    }
}

extension FriendRankRow {
    
    @ViewBuilder
    private var priorityImageView: some View {
        image
            .frame(width: 24, height: 24)
            .padding(.vertical, 16)
            .padding(.leading, 16)
    }
    
    private var descriptionView: some View {
        Text(self.friend.name)
            .padding(.leading, 8)
            .font(.pretendard(.regular, size: ._16))
            .foregroundColor(.designSystem(.g1))
    }
    
    private var uniqueNumView: some View {
        ZStack {
            Text("#" + "\(self.friend.id)")
                .padding(.all, 4)
                .font(.pretendard(.regular, size: ._10))
                .foregroundColor(.designSystem(.g1))
        }
        .background(
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.designSystem(.black))
        )
    }
    
    private var scoreView: some View {
        Text("\(self.friend.score)점")
            .padding(.horizontal, 16)
            .font(.pretendard(.medium, size: ._18))
            .foregroundColor(.designSystem(.g1))
    }
    
    private var image: some View {
        switch friend.rank {
        case 1: return Image("GoldGrade")
        case 2: return Image("SilverGrade")
        case 3: return Image("BronzeGrade")
        default: return Image("NoRank")
        }
    }
}
