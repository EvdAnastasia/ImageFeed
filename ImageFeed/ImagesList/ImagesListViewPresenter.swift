//
//  ImagesListViewPresenter.swift
//  ImageFeed
//
//  Created by Anastasiia on 20.11.2024.
//

import Foundation



final class ImagesListViewPresenter: ImagesListViewPresenterProtocol {
    
    // MARK: - Public Properties
    weak var view: ImagesListViewControllerProtocol?
    
    // MARK: - Private Properties
    private let imagesListService = ImagesListService.shared
    private var photos: [Photo] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    // MARK: - Public Methods
    func viewDidLoad() {
        imagesListService.fetchPhotosNextPage()
    }
    
    func updateTableView() {
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        view?.updateTableViewAnimated(oldCount: oldCount, newCount: newCount)
    }
    
    func getPhoto(by index: Int) -> Photo {
        photos[index]
    }
    
    func getPhotosCount() -> Int {
        photos.count
    }
    
    func fetchPhotosNextPage(for indexPath: IndexPath) {
        let testMode =  ProcessInfo.processInfo.arguments.contains("testMode")
        if indexPath.row + 1 == photos.count && testMode == false {
            imagesListService.fetchPhotosNextPage()
        }
    }
    
    func prepareCellData(for indexPath: IndexPath) -> CellData {
        let imageURL = photos[indexPath.row].largeImageURL
        let isLiked = photos[indexPath.row].isLiked
        
        var date: String
        if let createdAt = photos[indexPath.row].createdAt {
            date = dateFormatter.string(from: createdAt)
        } else {
            date = ""
        }
        
        return CellData(imageURL: imageURL, date: date, isLiked: isLiked)
    }
    
    func imageListCellDidTapLike(indexPath: IndexPath, cell: ImagesListCell) {
        let photo = photos[indexPath.row]
        view?.showProgressHUD()
        
        imagesListService.changeLike(photoId: photo.id, isLiked: !photo.isLiked) { [weak self] result in
            guard let self else { return }
            self.view?.hideProgressHUD()
            
            switch result {
            case .success:
                self.photos = self.imagesListService.photos
                cell.setIsLiked(self.photos[indexPath.row].isLiked)
            case .failure(let error):
                print("[ImagesListViewController.imageListCellDidTapLike]: NetworkError - \(String(describing: error))")
            }
        }
    }
}
