//
//  ImagesListViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Anastasiia on 20.11.2024.
//

import ImageFeed
import UIKit

final class ImagesListViewControllerSpy: UIViewController, ImagesListViewControllerProtocol {
    var presenter: ImagesListViewPresenterProtocol?
    var updateTableViewAnimatedCalled: Bool = false
    var showProgressHUDCalled: Bool = false
    
    func updateTableViewAnimated(oldCount: Int, newCount: Int) {
        updateTableViewAnimatedCalled = true
    }
    
    func showProgressHUD() {}
    
    func hideProgressHUD() {}
}
