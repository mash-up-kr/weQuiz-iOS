//
//  Friends.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct FriendRankResponseModel {
    public var hasNext: Bool
    public var cursorUserId: Int?
    public var cursorScore: Int?
    public var rankings: [FriendModel]
    
    public init(hasNext: Bool, cursorUserId: Int? = nil, cursorScore: Int? = nil, rankings: [FriendModel]) {
        self.hasNext = hasNext
        self.cursorUserId = cursorUserId
        self.cursorScore = cursorScore
        self.rankings = rankings
    }
}

public struct FriendModel {
    public var id: Int {
        return userInfoDto.id
    }
    public var userInfoDto: UserInfoModel
    public var score: Int
    
    public init(userInfoDto: UserInfoModel, score: Int) {
        self.userInfoDto = userInfoDto
        self.score = score
    }
}

public struct UserInfoModel {
    public var id: Int
    public var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension FriendRankResponseModel: Decodable { }
extension FriendRankResponseModel: Equatable { }

extension FriendModel: Decodable { }
extension FriendModel: Equatable { }
extension FriendModel: Identifiable { }

extension UserInfoModel: Decodable { }
extension UserInfoModel: Identifiable { }
extension UserInfoModel: Equatable { }
