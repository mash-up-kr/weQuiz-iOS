//
//  PhoneNumberInputModel.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum PhoneNumberInputModel {
    public enum Request {
        public struct OnTouchNavigationBack {
            public init() {}
        }
        
        public struct OnTouchGetVerificationCode {
            let signType: Screen.SignType
            let input: String
            
            public init(signType: Screen.SignType, input: String) {
                self.signType = signType
                self.input = input
            }
        }
    }
    
    public enum Response {
        public struct Naivgate {
            public enum Destination {
                case back
                case verificationCodeInput(String, Screen.SignType)
            }
            
            public let destination: Destination
        }
        
        public struct Toast {
            public enum `Type` {
                case exceededLimit
                case unknown
            }
            public let type: `Type`
        }
    }
}

