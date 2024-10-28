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
    private let jsonDecoder = JSONDecoder()
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastToken: String?
    
    // MARK: - Public Methods
    func fetchProfile(_ token: String, completion: @escaping (Result<ProfileResult, Error>) -> Void) {
        assert(Thread.isMainThread)
        
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
        
        let task = urlSession.data(for: request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                do {
                    let profileResult = try jsonDecoder.decode(ProfileResult.self, from: data)
                    completion(.success(profileResult))
                } catch {
                    print("failure decoding: \(error)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("failure: \(error)")
                completion(.failure(error))
            }
            
            self.task = nil
            self.lastToken = nil
        }
        
        self.task = task
        task.resume()
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
}
