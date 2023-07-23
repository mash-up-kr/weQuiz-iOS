//
//  VerificationCodeInputModel.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum VerificationCodeInputModel {
    public enum Request {
        public struct OnLoad {
            public init() {}
        }
        
        public struct OnTouchNavigationBack {
            public init() {}
        }
        
        public struct OnTouchReSend {
            public var phoneNumber: String
            
            public init(phoneNumber: String) {
                self.phoneNumber = phoneNumber
            }
        }
        
        public struct OnCompletedReSend {
            public init() {}
        }
        
        public struct OnRequestVerifyCode {
            public let remainTime: Int
            public let isValid: Bool
            public let code: String
            
            public init(remainTime: Int, isValid: Bool, code: String) {
                self.remainTime = remainTime
                self.isValid = isValid
                self.code = code
            }
        }
    }
    
    public enum Response {
        public struct Naivgate {
            public enum Destination {
                case back
                case userInformationInput
            }
            
            public let destination: Destination
        }

        public struct ResetTimer {
            public init() {}
        }
        
        public struct Toast {
            public enum `Type` {
                case invalidCode
                case timeout
                case expiredCode
                case resendCode
                case unknown
            }
            public let type: `Type`
        }
    }
}
