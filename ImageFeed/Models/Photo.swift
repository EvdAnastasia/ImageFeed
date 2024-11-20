//
//  Photo.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.11.2024.
//

import Foundation

public struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
    public init(id: String,
                size: CGSize,
                createdAt: Date?,
                welcomeDescription: String?,
                thumbImageURL: String,
                largeImageURL: String,
                isLiked: Bool
                
    ) {
        self.id = id
        self.size = size
        self.createdAt = createdAt
        self.welcomeDescription = welcomeDescription
        self.thumbImageURL = thumbImageURL
        self.largeImageURL = largeImageURL
        self.isLiked = isLiked
    }
}
