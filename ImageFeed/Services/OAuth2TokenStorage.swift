//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Anastasiia on 10.11.2024.
//

import Foundation
import SwiftKeychainWrapper

protocol OAuth2TokenStorageProtocol {
    var token: String? { get set }
    
    func deleteToken() -> Void
}

final class OAuth2TokenStorage: OAuth2TokenStorageProtocol {
    private let tokenKey = "accessToken"

    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: tokenKey)
        }
        set {
            if let newToken = newValue {
                KeychainWrapper.standard.set(newToken, forKey: tokenKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: tokenKey)
            }
        }
    }

    func deleteToken() {
        KeychainWrapper.standard.removeObject(forKey: tokenKey)
    }
}
