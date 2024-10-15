//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.10.2024.
//

import Foundation

enum OAuth2ServiceConstants {
    static let unsplashOAuthTokenURLString = "https://unsplash.com/oauth/token"
}

final class OAuth2Service {
    
    // MARK: - Private Properties
    static let shared = OAuth2Service()
    private var oauth2TokenStorage: OAuth2TokenStorageProtocol?
    
    // MARK: - Initializers
    private init() {
        oauth2TokenStorage = OAuth2TokenStorage()
    }
    
    // MARK: - Public Methods
    func fetchOAuthToken(code: String) {
        guard let request = makeOAuthTokenRequest(code: code) else {
            return print("Request not found")
        }
        
        let task = URLSession.shared.data(for: request) { result in
            switch result {
            case .success(let data):
                do {
                    let oauthTokenResponseBody = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    let token = oauthTokenResponseBody.token
                    self.oauth2TokenStorage?.token = token
                } catch {
                    print("failure decoding: \(error)")
                }
                
            case .failure(let error): print("failure: \(error)")
            }
        }
        
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
