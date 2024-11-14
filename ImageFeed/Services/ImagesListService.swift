//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.11.2024.
//

import Foundation

enum ImagesListServiceConstants {
    static let unsplashPhotosURLString = "https://api.unsplash.com/photos/"
}

enum ImagesListServiceError: Error {
    case invalidRequest
}

enum ImagesListServiceHTTPMethods {
    static let post = "POST"
    static let delete = "DELETE"
}

final class ImagesListService {
    
    // MARK: - Private Properties
    static let shared = ImagesListService()
    private(set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    private let storage = OAuth2Service.shared.oauth2TokenStorage
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private let dateFormatter = ISO8601DateFormatter()
    
    private init() {}
    
    // MARK: - Public Methods
    func fetchPhotosNextPage() {
        let nextPage = (lastLoadedPage ?? 0) + 1
        
        guard task == nil else { return }
        
        guard
            let request = makePhotosNextPageURLRequest(page: nextPage)
        else {
            print("Invalid photos request")
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self else { return }
            switch result {
            case .success(let data):
                data.forEach { photoResult in
                    self.photos.append(self.convert(photoResult: photoResult))
                }
                
                NotificationCenter.default
                    .post(
                        name: ImagesListService.didChangeNotification,
                        object: self)
                
                lastLoadedPage = nextPage
                
            case .failure(let error):
                print("[ImagesListService.fetchPhotosNextPage]: NetworkError - \(String(describing: error))")
            }
            
            self.task = nil
        }
        
        self.task = task
        task.resume()
    }
    
    func changeLike(photoId: String, isLiked: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        guard task == nil else { return }
        
        let requestMethod = isLiked ? ImagesListServiceHTTPMethods.post : ImagesListServiceHTTPMethods.delete
        
        guard
            let request = makeChangeLikeURLRequest(id: photoId, requestMethod: requestMethod)
        else {
            print("Invalid changeLike request")
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<Photos, Error>) in
            guard let self else { return }
            switch result {
            case .success:
                if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                    let photo = self.photos[index]
                    let newPhoto = Photo(
                        id: photo.id,
                        size: photo.size,
                        createdAt: photo.createdAt,
                        welcomeDescription: photo.welcomeDescription,
                        thumbImageURL: photo.thumbImageURL,
                        largeImageURL: photo.largeImageURL,
                        isLiked: !photo.isLiked
                    )
                    self.photos[index] = newPhoto
                }
                completion(.success(()))
            case .failure(let error):
                print("[ImagesListService.changeLike]: NetworkError - \(String(describing: error))")
                completion(.failure(error))
            }
            
            self.task = nil
        }
        
        self.task = task
        task.resume()
    }
    
    // MARK: - Private Methods
    private func makePhotosNextPageURLRequest(page: Int) -> URLRequest? {
        guard let urlComponents = URLComponents(string: ImagesListServiceConstants.unsplashPhotosURLString + "?page=\(page)") else {
            print("URLComponents not found")
            return nil
        }
        
        guard let url = urlComponents.url else {
            print("URL not found")
            return nil
        }
        
        guard let token = storage?.token else {
            print("Token not found")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func convert(photoResult: PhotoResult) -> Photo {
        let photo = Photo(id: photoResult.id,
                          size: CGSize(width: photoResult.width, height: photoResult.height),
                          createdAt: dateFormatter.date(from: photoResult.createdAt),
                          welcomeDescription: photoResult.welcomeDescription,
                          thumbImageURL: photoResult.urls.thumbImageURL,
                          largeImageURL: photoResult.urls.largeImageURL,
                          isLiked: photoResult.isLiked
        )
        
        return photo
    }
    
    private func makeChangeLikeURLRequest(id: String, requestMethod: String) -> URLRequest? {
        guard let urlComponents = URLComponents(string: ImagesListServiceConstants.unsplashPhotosURLString + "\(id)/like") else {
            print("URLComponents not found")
            return nil
        }
        
        guard let url = urlComponents.url else {
            print("URL not found")
            return nil
        }
        
        guard let token = storage?.token else {
            print("Token not found")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = requestMethod
        return request
    }
}
