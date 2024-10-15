//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.10.2024.
//

struct OAuthTokenResponseBody: Decodable {
    let token: String
    let tokenType: String
    let scope: String
    let createdAt: Int
    
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
        case createdAt = "created_at"
    }
}
