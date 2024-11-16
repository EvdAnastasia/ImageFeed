//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Anastasiia on 28.10.2024.
//

import Foundation

enum ProfileServiceConstants {
    static let unsplashProfileURLString = "https://api.unsplash.com/me"
}

enum ProfileServiceError: Error {
    case invalidRequest
}

final class ProfileService {
    
    // MARK: - Private Properties
    static let shared = ProfileService()
    private(set) var profile: Profile?
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastToken: String?
    
    private init() {}
    
    // MARK: - Public Methods
    func fetchProfile(_ token: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {
        guard lastToken != token else {
            completion(.failure(ProfileServiceError.invalidRequest))
            return
        }
        
        task?.cancel()
        lastToken = token
        
        guard
            let request = makeProfileRequest(token: token)
        else {
            completion(.failure(ProfileServiceError.invalidRequest))
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                profile = convert(model: data)
                completion(.success(data))
                
            case .failure(let error):
                print("[ProfileService.fetchProfile]: NetworkError - \(String(describing: error))")
                completion(.failure(error))
            }
            
            self.task = nil
            self.lastToken = nil
        }
        
        self.task = task
        task.resume()
    }
    
    func cleanProfileData() {
        profile = nil
    }
    
    // MARK: - Private Methods
    private func makeProfileRequest(token: String) -> URLRequest? {
        guard let urlComponents = URLComponents(string: ProfileServiceConstants.unsplashProfileURLString) else {
            print("URLComponents not found")
            return nil
        }
        
        guard let url = urlComponents.url else {
            print("URL not found")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func convert(model: ProfileResult) -> Profile {
        Profile(
            username: model.username,
            firstName: model.firstName,
            lastName: model.lastName,
            bio: model.bio
        )
    }
}
