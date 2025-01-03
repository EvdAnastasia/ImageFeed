//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Anastasiia on 09.11.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let imagesListViewController = storyboard.instantiateViewController(
            withIdentifier: "ImagesListViewController"
        ) as? ImagesListViewControllerProtocol else { return }
        
        let imagesListViewPresenter = ImagesListViewPresenter()
        imagesListViewPresenter.view = imagesListViewController
        imagesListViewController.presenter = imagesListViewPresenter
        
        let profileViewController = ProfileViewController()
        let profileViewPresenter = ProfileViewPresenter()
        profileViewPresenter.view = profileViewController
        profileViewController.presenter = profileViewPresenter
        
        imagesListViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabEditorialActive"),
            selectedImage: nil
        )
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "TabProfileActive"),
            selectedImage: nil
        )
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
    
}
