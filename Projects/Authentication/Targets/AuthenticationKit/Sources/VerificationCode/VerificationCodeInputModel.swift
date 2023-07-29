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
            let type: AuthenticationScreen.SignType
            let phoneNumber: String
            let remainTime: Int
            let isValid: Bool
            let code: String
            
            public init(type: AuthenticationScreen.SignType, phoneNumber: String, remainTime: Int, isValid: Bool, code: String) {
                self.type = type
                self.phoneNumber = phoneNumber
                self.remainTime = remainTime
                self.isValid = isValid
                self.code = code
            }
        }
        
        public struct OnTouchSignUp {
            let type: AuthenticationScreen.SignType
            let phoneNumber: String
            
            public init(type: AuthenticationScreen.SignType, phoneNumber: String) {
                self.type = type
                self.phoneNumber = phoneNumber
            }
        }
    }
    
    public enum Response {
        public struct Naivgate {
            public enum Destination {
                case back
                case userInformationInput(String)
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
        
        public struct Modal {
            public enum `Type` {
                case notSignedUpUser
                case unknown
            }
            public let type: `Type`
        }
    }
}
