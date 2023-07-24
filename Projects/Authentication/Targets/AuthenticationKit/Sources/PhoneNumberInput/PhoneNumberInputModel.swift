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
            public let input: String
            
            public init(input: String) {
                self.input = input
            }
        }
    }
    
    public enum Response {
        public struct Naivgate {
            public enum Destination {
                case back
                case verificationCodeInput(String)
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

