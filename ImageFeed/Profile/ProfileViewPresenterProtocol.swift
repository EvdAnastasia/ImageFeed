//
//  ProfileViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Anastasiia on 19.11.2024.
//

import Foundation

public protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func updateAvatar()
    func updateProfileDetails()
    func didTapExitButton()
    func logout()
}
