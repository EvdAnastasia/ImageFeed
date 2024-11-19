//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Anastasiia on 19.11.2024.
//

import Foundation

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfileViewPresenterProtocol? { get set }
    func updateProfileDetails(profile: Profile)
    func updateAvatar(with url: URL)
    func showExitAlert()
}
