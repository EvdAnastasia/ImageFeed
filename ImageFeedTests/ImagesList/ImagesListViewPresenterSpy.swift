//
//  ImagesListViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Anastasiia on 20.11.2024.
//

import ImageFeed
import UIKit

final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    
    func viewDidLoad() {}
    
    func updateTableView() {}
    
    func getPhoto(by index: Int) -> ImageFeed.Photo {
        return Photo(
            id: "1",
            size: CGSize.zero,
            createdAt: nil,
            welcomeDescription: nil,
            thumbImageURL: "thumbImageURL",
            largeImageURL: "largeImageURL",
            isLiked: true
        )
    }
    
    func getPhotosCount() -> Int {
        10
    }
    
    func fetchPhotosNextPage(for indexPath: IndexPath) {}
    
    func imageListCellDidTapLike(indexPath: IndexPath, cell: ImageFeed.ImagesListCell) {}
    
    func prepareCellData(for indexPath: IndexPath) -> ImageFeed.CellData {
        ImageFeed.CellData(
            imageURL: "https://practicum.yandex.ru/",
            date: "22:01:2024",
            isLiked: true
        )
    }
    
}
