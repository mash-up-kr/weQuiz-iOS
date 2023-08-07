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
            let signType: AuthenticationScreen.SignType
            let input: String
            
            public init(signType: AuthenticationScreen.SignType, input: String) {
                self.signType = signType
                self.input = input
            }
        }
    }
    
    public enum Response {
        public struct Naivgate {
            public enum Destination {
                case back
                case verificationCodeInput(String, AuthenticationScreen.SignType)
            }
            
            public let destination: Destination
        }
        
        public struct Toast: Identifiable, Equatable {
            public enum `Type`: Equatable {
                case exceededLimit
                case errorMessage(String)
                case unknown
            }
            public let id = UUID()
            public let type: `Type`
            
            static let `default`: Toast = .init(type: .unknown)
        }
        
        public struct Progress{
            public let show: Bool
        }
    }
}

