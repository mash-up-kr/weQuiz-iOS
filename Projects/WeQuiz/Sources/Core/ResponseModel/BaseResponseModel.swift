//
//  BaseResponseModel.swift
//  CoreKit
//
//  Created by AhnSangHoon on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct BaseDataResponseModel<T: Decodable>: Decodable {
    public let code: String
    public let message: String?
    public let data: T?
}
