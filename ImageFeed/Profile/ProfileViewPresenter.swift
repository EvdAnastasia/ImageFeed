//
//  ProfileViewPresenter.swift
//  ImageFeed
//
//  Created by Anastasiia on 19.11.2024.
//

import Foundation

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    // MARK: - Public Properties
    weak var view: ProfileViewControllerProtocol?
    
    // MARK: - Private Properties
    private let profileService = ProfileService.shared
    private let profileLogoutService = ProfileLogoutService.shared
    
    func viewDidLoad() {
        updateProfileDetails()
        updateAvatar()
    }
    
    func updateProfileDetails() {
        guard let profile = profileService.profile else { return }
        view?.updateProfileDetails(profile: profile)
    }
    
    func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        view?.updateAvatar(with: url)
    }
    
    func didTapExitButton() {
        view?.showExitAlert()
    }
    
    func logout() {
        profileLogoutService.logout()
    }
    
}
