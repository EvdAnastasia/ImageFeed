//
//  ImagesListViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Anastasiia on 20.11.2024.
//

@testable import ImageFeed
import UIKit

final class ImagesListViewPresenterSpy: ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    var photosCount: Int = 10
    
    func viewDidLoad() {}
    
    func updateTableView() {}
    
    func getPhoto(by index: Int) -> Photo {
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
    
    func fetchPhotosNextPage(for indexPath: IndexPath) {}
    
    func imageListCellDidTapLike(indexPath: IndexPath, cell: ImagesListCell) {}
    
    func prepareCellData(for indexPath: IndexPath) -> CellData {
        CellData(
            imageURL: "https://practicum.yandex.ru/",
            date: "22:01:2024",
            isLiked: true
        )
    }
    
}
