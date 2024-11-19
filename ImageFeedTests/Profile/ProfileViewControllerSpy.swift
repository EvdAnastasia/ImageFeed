//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Anastasiia on 19.11.2024.
//

import ImageFeed
import Foundation

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ProfileViewPresenterProtocol?
    var updateProfileDetailsCalled: Bool = false
    var updateAvatarCalled: Bool = false
    var showExitAlertCalled: Bool = false
    
    func updateProfileDetails(profile: ImageFeed.Profile) {
        updateProfileDetailsCalled = true
    }
    
    func updateAvatar(with url: URL) {
        updateAvatarCalled = true
    }
    
    func showExitAlert() {
        showExitAlertCalled = true
    }
}
