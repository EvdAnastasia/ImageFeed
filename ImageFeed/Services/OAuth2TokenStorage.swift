//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Anastasiia on 15.10.2024.
//

import Foundation

final class OAuth2TokenStorage {
    private enum Keys: String {
        case token
    }
    
    private let storage: UserDefaults = .standard
}

extension OAuth2TokenStorage: OAuth2TokenStorageProtocol {
    var token: String {
        get {
            storage.string(forKey: Keys.token.rawValue) ?? ""
        }
        set {
            storage.set(newValue, forKey: Keys.token.rawValue)
        }
    }
}
