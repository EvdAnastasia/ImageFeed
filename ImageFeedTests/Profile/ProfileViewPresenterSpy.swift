//
//  ProfileViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Anastasiia on 19.11.2024.
//

import ImageFeed
import Foundation

final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol?
    var viewDidLoadCalled: Bool = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func updateAvatar() {}
    
    func updateProfileDetails() {}
    
    func didTapExitButton() {}
    
    func logout() {}
    
}
