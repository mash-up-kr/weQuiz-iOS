//
//  ResponseModel.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

struct EmptyResponseModel: Decodable { }

public struct UserResponseModel: Decodable {
    let id: Int
    let nickname: String
    let descritpion: String?
}
