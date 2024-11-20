//
//  ImagesListViewTests.swift
//  ImageFeedTests
//
//  Created by Anastasiia on 20.11.2024.
//

@testable import ImageFeed
import XCTest

final class ImagesListViewTests: XCTestCase {
    func testGetPhotosCount() {
        // given
        let viewController = ImagesListViewController()
        let presenter = ImagesListViewPresenterSpy()
        presenter.view = viewController
        viewController.presenter = presenter
        
        // when
        let photosCount = viewController.presenter?.getPhotosCount()
        
        // then
        XCTAssertEqual(photosCount, 10)
    }
    
    func testGetPhoto() {
        // given
        let presenter = ImagesListViewPresenterSpy()
        let testPhoto = Photo(
            id: "1",
            size: CGSize.zero,
            createdAt: nil,
            welcomeDescription: nil,
            thumbImageURL: "thumbImageURL",
            largeImageURL: "largeImageURL",
            isLiked: true
        )
        
        // when
        let presenterPhoto = presenter.getPhoto(by: 1)
        
        // then
        XCTAssertEqual(testPhoto.id, presenterPhoto.id)
        XCTAssertEqual(testPhoto.size, presenterPhoto.size)
        XCTAssertEqual(testPhoto.thumbImageURL, presenterPhoto.thumbImageURL)
        XCTAssertEqual(testPhoto.largeImageURL, presenterPhoto.largeImageURL)
        XCTAssertTrue(testPhoto.isLiked)
    }
    
    func testUpdatedTableViewCall() {
        // given
        let viewController = ImagesListViewControllerSpy()
        
        // when
        viewController.updateTableViewAnimated(oldCount: 1, newCount: 2)
        
        // then
        XCTAssert(viewController.updateTableViewAnimatedCalled)
    }
    
    func testPrepareCellData() {
        // given
        let presenter = ImagesListViewPresenterSpy()
        let testCellData = CellData(
            imageURL: "https://practicum.yandex.ru/",
            date: "22:01:2024",
            isLiked: true
        )
        
        // when
        let cellData = presenter.prepareCellData(for: IndexPath(row: 1, section: 1))
        
        // then
        XCTAssertEqual(cellData.imageURL, testCellData.imageURL)
        XCTAssertEqual(cellData.date, testCellData.date)
        XCTAssertTrue(cellData.isLiked)
    }
}
