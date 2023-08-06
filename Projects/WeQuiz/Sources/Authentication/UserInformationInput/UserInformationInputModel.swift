//
//  UserInformationInputModel.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum UserInformationInputModel {
    public struct Request {
        public struct OnTouchNavigationBack {
            public init() {}
        }
        
        public struct OnRequestSignUp {
            let phone: String
            let nickname: String
            let description: String?
            
            public init(phone: String, nickname: String, description: String?) {
                self.phone = phone
                self.nickname = nickname
                self.description = description
            }
        }
    }
    
    public struct Response {
        public struct Navigate {
            public enum Destination {
                case back
                case finish(String)
            }
            public let destination: Destination
        }
        
        public struct Toast {
            public enum `Type`: Equatable {
                case signUpFailed(reason: String)
                case unknown
                case none
            }
            public let type: `Type`
        }
        
        public struct Progress {
            public let show: Bool
        }
    }
}
