//
//  CellData.swift
//  ImageFeed
//
//  Created by Anastasiia on 20.11.2024.
//

public struct CellData {
    let imageURL: String
    let date: String
    let isLiked: Bool
    
    public init(imageURL: String, date: String, isLiked: Bool) {
        self.imageURL = imageURL
        self.date = date
        self.isLiked = isLiked
    }
}
