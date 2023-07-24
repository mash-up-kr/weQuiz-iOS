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
    public var cursorQuizAnserId: Int
    public var rankings: [FriendModel]
}

public struct FriendModel {
    public var id: Int
    public var userInfoDto: UserInfoModel
    public var score: Int
    public var quizAnswerId: Int
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

public var friendsRankSample = FriendRankGroupModel(hasNext: true, cursorQuizAnserId: 0,
                                             rankings: [FriendModel(id: 0, userInfoDto: UserInfoModel(id: 0, name: "이름1"), score: 100, quizAnswerId: 0),
                                                        FriendModel(id: 1, userInfoDto: UserInfoModel(id: 1, name: "이름2"), score: 90, quizAnswerId: 0),
                                                        FriendModel(id: 2, userInfoDto: UserInfoModel(id: 2, name: "이름3"), score: 80, quizAnswerId: 0),
                                                        FriendModel(id: 3, userInfoDto: UserInfoModel(id: 3, name: "이름4"), score: 70, quizAnswerId: 0),
                                                        FriendModel(id: 4, userInfoDto: UserInfoModel(id: 4, name: "이름5"), score: 60, quizAnswerId: 0),
                              ])
