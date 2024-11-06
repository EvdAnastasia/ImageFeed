//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Anastasiia on 20.10.2024.
//

import UIKit
import SwiftKeychainWrapper

final class SplashViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let secureDataManager = SecureDataManager.shared
    private let ShowAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let TabBarViewControllerIdentifier = "TabBarViewController"
    
    // MARK: - Overrides Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = secureDataManager.getToken() {
            fetchProfile(token: token)
        } else {
            performSegue(withIdentifier: ShowAuthenticationScreenSegueIdentifier, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowAuthenticationScreenSegueIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else { fatalError("Failed to prepare for \(ShowAuthenticationScreenSegueIdentifier)") }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Private Methods
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: TabBarViewControllerIdentifier)
        
        window.rootViewController = tabBarController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
        
        guard let token = secureDataManager.getToken() else {
            return
        }
        fetchProfile(token: token)
    }
    
    private func fetchProfile(token: String) {
        UIBlockingProgressHUD.show()
        
        profileService.fetchProfile(token) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            
            guard let self = self else { return }
            switch result {
            case .success(let data):
                profileImageService.fetchProfileImageURL(username: data.username) { _ in }
                self.switchToTabBarController()
                
            case .failure(let error):
                // TODO [Sprint 11] Покажите ошибку получения профиля
                print(error)
                break
            }
        }
    }
}
