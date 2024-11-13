//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.10.2024.
//

import Foundation
import SwiftKeychainWrapper

enum OAuth2ServiceConstants {
    static let unsplashOAuthTokenURLString = "https://unsplash.com/oauth/token"
}

enum AuthServiceError: Error {
    case invalidRequest
}

final class OAuth2Service {
    
    // MARK: - Public Properties
    var oauth2TokenStorage: OAuth2TokenStorageProtocol?
    
    // MARK: - Private Properties
    static let shared = OAuth2Service()
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastCode: String?
    
    // MARK: - Initializers
    private init() {
        oauth2TokenStorage = OAuth2TokenStorage()
    }
    
    // MARK: - Public Methods
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {        
        guard lastCode != code else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        task?.cancel()
        lastCode = code
        
        guard
            let request = makeOAuthTokenRequest(code: code)
        else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                let token = data.token
                self.oauth2TokenStorage?.token = token
                completion(.success(token))
                
            case .failure(let error):
                print("[OAuth2Service.fetchOAuthToken]: NetworkError - \(String(describing: error))")
                completion(.failure(error))
            }
            
            self.task = nil
            self.lastCode = nil
        }
        
        self.task = task
        task.resume()
    }
    
    // MARK: - Private Methods
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: OAuth2ServiceConstants.unsplashOAuthTokenURLString) else {
            print("URLComponents not found")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]
        
        guard let url = urlComponents.url else {
            print("URL not found")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}
