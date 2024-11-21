//
//  ImagesListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Anastasiia on 20.11.2024.
//

import UIKit

public protocol ImagesListViewControllerProtocol: UIViewController {
    var presenter: ImagesListViewPresenterProtocol? { get set }
    func updateTableViewAnimated(oldCount: Int, newCount: Int)
    func showProgressHUD()
    func hideProgressHUD()
}
