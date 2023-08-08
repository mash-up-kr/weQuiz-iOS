//
//  AuthManger.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/22.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

import FirebaseAuth

public class AuthManager: ObservableObject {
    public enum SignInError: Error {
        case invalidCode
        case timeout
        case unknown
    }
    
    public enum PhoneNumberVerificationError: Error {
        case fail(String)
    }
    
    public static let shared: AuthManager = .init()
    
    private init() {}
    
    private(set) var userId: String?
    private var verificationID: String?
    var signedOut: Bool = false
    var withdrawal: Bool = false
}

public extension AuthManager {
    var token: String? {
        UserDefaults.standard.string(forKey: "token")
    }

    func verifyPhoneNumber(
        _ phoneNumber: String,
        completion: ((Result<Bool, PhoneNumberVerificationError>) -> Void)? = nil
    ) {
        var convertedPhoneNumber = phoneNumber
        convertedPhoneNumber.removeFirst()
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(
                "+82\(convertedPhoneNumber)",
                uiDelegate: nil
            ) { [weak self] verificationID, error in
                if let error = error {
                    completion?(.failure(.fail(error.localizedDescription)))
                } else {
                    self?.verificationID = verificationID
                    completion?(.success(true))
                }
            }
    }
    
    func registerPhoneNumber(with code: String, completion: @escaping (Result<(Bool, String?), SignInError>) -> Void) {
        guard let verificationID = verificationID else {
            completion(.failure(.unknown))
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: code
        )
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            if let error = error as? NSError {
                let authErrorCode = AuthErrorCode(_nsError: error).code
                switch authErrorCode {
                case .expiredActionCode :
                    completion(.failure(.timeout))
                case .invalidVerificationCode:
                    completion(.failure(.invalidCode))
                default:
                    completion(.failure(.unknown))
                }
                debugPrint(authErrorCode)
                return
            }
            
            guard let _ = result else {
                completion(.failure(.unknown))
                return
            }
            
            self?.userId = result?.user.uid
            
            completion(.success((true, result?.user.uid)))
        }
    }
    
    func storeToken(_ completion: @escaping () -> Void) {
        UserDefaults.standard.set(userId, forKey: "token")
        verificationID = nil
        userId = nil
        completion()
    }
    
    func signOut(_ completion: () -> Void) {
        UserDefaults.standard.removeObject(forKey: "token")
        completion()
    }
    
    func withdrawal(_ completion: @escaping (Bool) -> Void) {
        UserDefaults.standard.removeObject(forKey: "token")
        let user = Auth.auth().currentUser
        user?.delete(completion: { error in
            if let error = error  {
                completion(false)
            } else {
                completion(true)
            }
        })
    }
}
