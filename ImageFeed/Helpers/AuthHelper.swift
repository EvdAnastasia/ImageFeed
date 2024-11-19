//
//  AuthHelper.swift
//  ImageFeed
//
//  Created by Anastasiia on 19.11.2024.
//

import Foundation

final class AuthHelper: AuthHelperProtocol {
    
    // MARK: - Public Properties
    let configuration: AuthConfiguration
    
    // MARK: - Initializers
    init(configuration: AuthConfiguration = .standard) {
        self.configuration = configuration
    }
    
    // MARK: - Public Methods
    func authRequest() -> URLRequest? {
        guard let url = authURL() else {
            print("URL not found")
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    func code(from url: URL) -> String? {
        if
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == "code" })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
    
    // MARK: - Private Methods
    private func authURL() -> URL? {
        guard var urlComponents = URLComponents(string: configuration.authURLString) else {
            print("URLComponents not found")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: configuration.accessKey),
            URLQueryItem(name: "redirect_uri", value: configuration.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: configuration.accessScope)
        ]
        
        return urlComponents.url
    }
}
