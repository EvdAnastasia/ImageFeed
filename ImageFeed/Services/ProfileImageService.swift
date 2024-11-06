//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Anastasiia on 01.11.2024.
//

import Foundation
import SwiftKeychainWrapper

enum ProfileImageServiceConstants {
    static let unsplashUserURLString = "https://api.unsplash.com/users/"
}

enum ProfileImageServiceError: Error {
    case invalidRequest
}

final class ProfileImageService {
    
    // MARK: - Private Properties
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    private(set) var avatarURL: String?
    private let jsonDecoder = JSONDecoder()
    private let urlSession = URLSession.shared
    private let secureDataManager = SecureDataManager.shared
    private var task: URLSessionTask?
    private var lastUsername: String?
    
    private init() {}
    
    // MARK: - Public Methods
    func fetchProfileImageURL(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard lastUsername != username else {
            completion(.failure(ProfileImageServiceError.invalidRequest))
            return
        }
        
        task?.cancel()
        lastUsername = username
        
        guard
            let request = makeProfileImageURLRequest(username: username)
        else {
            completion(.failure(ProfileImageServiceError.invalidRequest))
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                let profileImageURL = data.profileImage.large
                avatarURL = profileImageURL
                completion(.success(profileImageURL))
                
                NotificationCenter.default
                    .post(
                        name: ProfileImageService.didChangeNotification,
                        object: self,
                        userInfo: ["URL": profileImageURL])
                
            case .failure(let error):
                print("[ProfileImageService.fetchProfileImageURL]: NetworkError - \(String(describing: error))")
                completion(.failure(error))
            }
            
            self.task = nil
            self.lastUsername = nil
        }
        
        self.task = task
        task.resume()
    }
    
    // MARK: - Private Methods
    private func makeProfileImageURLRequest(username: String) -> URLRequest? {
        guard let urlComponents = URLComponents(string: ProfileImageServiceConstants.unsplashUserURLString + "\(username)") else {
            print("URLComponents not found")
            return nil
        }
        
        guard let url = urlComponents.url else {
            print("URL not found")
            return nil
        }
        
        guard let token = secureDataManager.getToken() else {
            print("Token not found")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
