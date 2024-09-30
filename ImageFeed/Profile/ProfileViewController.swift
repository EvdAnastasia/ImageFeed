//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.09.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Avatar
        let avatarImage = UIImage(named: "Avatar")
        let avatarImageView = UIImageView(image: avatarImage)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)
        
        avatarImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        
        // Name Label
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        nameLabel.font = .boldSystemFont(ofSize: 23.0)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8).isActive = true
        
        // Login Name Label
        let loginNameLabel = UILabel()
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.textColor = .ypGray
        loginNameLabel.font = .systemFont(ofSize: 13.0)
        
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
        loginNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        loginNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        
        // Description Label
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Hello, World!"
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = .systemFont(ofSize: 13.0)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8).isActive = true
        
        // Logout Button
        let logoutButton = UIButton()
        let buttonImage = UIImage(named: "LogoutButton")
        logoutButton.setImage(buttonImage, for: .normal)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        logoutButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
    }
}
