//
//  Profile.swift
//  HomeUI
//
//  Created by 최원석 on 2023/06/11.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

struct MyInfoModel {
    var id: Int
    var image: String
    var nickname: String
    var contents: String
}

extension MyInfoModel: Decodable { }
extension MyInfoModel: Equatable { }

var myInfoSamlple: MyInfoModel = MyInfoModel(id: 0, image: "circle", nickname: "교대역 강다니엘", contents: "오늘밤 주인공은 나야나!")
