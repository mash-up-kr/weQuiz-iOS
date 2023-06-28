//
//  Friends.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

struct Friend {
    var name: String
    var originalNum: String
    var rank: Int
    var Score: Int
    let id: UUID = UUID()
}

extension Friend: Decodable { }
extension Friend: Identifiable { }
extension Friend: Equatable { }

var friendsRankSample = [
    Friend(name: "이름1", originalNum: "asdasdasds", rank: 1, Score: 100),
    Friend(name: "이름2", originalNum: "asdasdasds", rank: 2, Score: 100),
    Friend(name: "이름3", originalNum: "asdasdasds", rank: 3, Score: 100),
    Friend(name: "이름", originalNum: "asdasdasds", rank: 1, Score: 100),
    Friend(name: "이름", originalNum: "asdasdasds", rank: 1, Score: 100),
    Friend(name: "이름", originalNum: "asdasdasds", rank: 1, Score: 100)
]
