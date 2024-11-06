//
//  SecureDataManager.swift
//  ImageFeed
//
//  Created by Anastasiia on 06.11.2024.
//

import Foundation
import SwiftKeychainWrapper

final class SecureDataManager {
    
    // MARK: - Private Properties
    static let shared = SecureDataManager()
    private let tokenKey = "Auth token"
    
    // MARK: - Initializers
    private init() {}
    
    func saveToken(token: String) -> Bool {
        let isSuccess = KeychainWrapper.standard.set(token, forKey: tokenKey)
        return isSuccess
    }
    
    func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: tokenKey)
    }
    
    func deleteToken() -> Bool {
        let removeSuccessful = KeychainWrapper.standard.removeObject(forKey: tokenKey)
        return removeSuccessful
    }
}
