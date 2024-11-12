//
//  UserResult.swift
//  ImageFeed
//
//  Created by Anastasiia on 01.11.2024.
//

struct UserResult: Decodable {
    let profileImage: AvatarURLs
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct AvatarURLs: Decodable {
    let large: String
    
    private enum CodingKeys: String, CodingKey {
        case large = "large"
    }
}
