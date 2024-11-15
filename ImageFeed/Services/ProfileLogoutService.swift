//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by Anastasiia on 15.11.2024.
//

import Foundation
import WebKit

final class ProfileLogoutService {
    // MARK: - Private Properties
    static let shared = ProfileLogoutService()
    private let storage = OAuth2Service.shared.oauth2TokenStorage
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared
    
    // MARK: - Initializers
    private init() { }
    
    // MARK: - Public Methods
    func logout() {
        cleanCookies()
        storage?.deleteToken()
        profileService.cleanProfileData()
        profileImageService.cleanAvatarData()
        imagesListService.cleanPhotosData()
    }
    
    // MARK: - Private Methods
    private func cleanCookies() {
        // Очищаем все куки из хранилища
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        // Запрашиваем все данные из локального хранилища
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            // Массив полученных записей удаляем из хранилища
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}

