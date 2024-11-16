//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.11.2024.
//

struct PhotoResult: Decodable {
    let id: String
    let width: Int
    let height: Int
    let createdAt: String
    let welcomeDescription: String?
    let isLiked: Bool
    let urls: UrlsResult
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case width = "width"
        case height = "height"
        case createdAt = "created_at"
        case welcomeDescription = "description"
        case isLiked = "liked_by_user"
        case urls = "urls"
    }
}

struct UrlsResult: Decodable {
    let thumbImageURL: String
    let largeImageURL: String
    
    private enum CodingKeys: String, CodingKey {
        case thumbImageURL = "thumb"
        case largeImageURL = "full"
    }
}

struct Photos: Decodable {
    let photo: PhotoResult
}
