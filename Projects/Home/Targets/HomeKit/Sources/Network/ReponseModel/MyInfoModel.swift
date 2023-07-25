//
//  Profile.swift
//  HomeUI
//
//  Created by 최원석 on 2023/06/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct MyInfoModel {
    public var id: Int
    public var image: String?
    public var nickname: String
    public var description: String
    
    public init(id: Int, image: String, nickname: String, contents: String) {
        self.id = id
        self.image = image
        self.nickname = nickname
        self.description = contents
    }
    
    enum CodigKeys: String, CodingKey {
        case id
        case image
        case nickname
        case contents = "description"
    }
}

extension MyInfoModel: Decodable { }
extension MyInfoModel: Identifiable { }

public var myInfoSamlple: MyInfoModel = MyInfoModel(id: 0, image: "circle", nickname: "교대역 강다니엘", contents: "오늘밤 주인공은 나야나!")
