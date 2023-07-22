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
    @Binding var friend: Friend
    
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

extension FriendsRow {
    private var priorityImageView: some View {
        image
            .padding(.vertical, 16)
            .padding(.leading, 16)
    }
    
    private var descriptionView: some View {
        Text(self.friend.name)
            .padding(.horizontal, 8)
            .font(.pretendard(.regular, size: ._16))
            .foregroundColor(.designSystem(.g1))
    }
    
    private var uniqueNumView: some View {
        ZStack {
            Text("#" + self.friend.originalNum)
                .padding(.all, 4)
                .font(.pretendard(.regular, size: ._10))
                .foregroundColor(.designSystem(.g1))
        }
        .background(.black)
        .cornerRadius(4)
    }
    
    private var scoreView: some View {
        Text("\(self.friend.Score)점")
            .padding(.horizontal, 16)
            .font(.pretendard(.medium, size: ._18))
            .foregroundColor(.designSystem(.g1))
    }
    
    
    private var friendInfoDescription: some View {
        HStack {
            image
                .padding(.vertical, 16)
                .padding(.leading, 16)
            
            Text(self.friend.name)
                .padding(.horizontal, 8)
                .font(.pretendard(.regular, size: ._16))
                .foregroundColor(.designSystem(.g1))
            
            ZStack {
                Text("#" + self.friend.originalNum)
                    .padding(.all, 4)
                    .font(.pretendard(.regular, size: ._10))
                    .foregroundColor(.designSystem(.g1))
            }
            .background(.black)
            .cornerRadius(4)
            
            Spacer()
            
            Text("\(self.friend.Score)점")
                .padding(.horizontal, 16)
                .font(.pretendard(.medium, size: ._18))
                .foregroundColor(.designSystem(.g1))
        }
        .frame(height: 58)
        .background(Color.designSystem(.g8))
        .cornerRadius(16)
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

