//
//  RequestModel.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct JoinRequestModel: Encodable {
    let token: String
    let phone: String
    let nickname: String
    let description: String?
}
