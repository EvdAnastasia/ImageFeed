//
//  ImagesListViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Anastasiia on 20.11.2024.
//

import Foundation

public protocol ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    func viewDidLoad()
    func updateTableView()
    func getPhoto(by index: Int) -> Photo
    func getPhotosCount() -> Int
    func fetchPhotosNextPage(for indexPath: IndexPath)
    func imageListCellDidTapLike(indexPath: IndexPath, cell: ImagesListCell)
    func prepareCellData(for indexPath: IndexPath) -> CellData
}
