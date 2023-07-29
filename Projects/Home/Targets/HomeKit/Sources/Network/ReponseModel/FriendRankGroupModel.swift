//
//  Friends.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct FriendRankGroupModel {
    public var hasNext: Bool
    public var cursorUserId: Int?
    public var cursorScore: Int?
    public var rankings: [FriendModel]
}

public struct FriendModel {
    public var id: Int {
        return userInfoDto.id
    }
    public var userInfoDto: UserInfoModel
    public var score: Int
}

public struct UserInfoModel {
    public var id: Int
    public var name: String
}

extension FriendRankGroupModel: Decodable { }
extension FriendRankGroupModel: Equatable { }

extension FriendModel: Decodable { }
extension FriendModel: Equatable { }
extension FriendModel: Identifiable { }

extension UserInfoModel: Decodable { }
extension UserInfoModel: Identifiable { }
extension UserInfoModel: Equatable { }
