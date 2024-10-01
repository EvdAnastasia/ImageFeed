//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Anastasiia on 13.09.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Avatar")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "LogoutButton")
        button.setImage(buttonImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = .ypWhite
        label.font = .boldSystemFont(ofSize: 23.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@ekaterina_nov"
        label.textColor = .ypGray
        label.font = .systemFont(ofSize: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = .ypWhite
        label.font = .systemFont(ofSize: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    // MARK: - Private Methods
    private func avatarImageViewConstrains() -> [NSLayoutConstraint] {
        return [
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1.0/1.0),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ]
    }
    
    private func logoutButtonConstrains() -> [NSLayoutConstraint] {
        return [
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ]
    }
    
    private func nameLabelConstrains() ->[NSLayoutConstraint] {
        return [
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8)
        ]
    }
    
    private func loginNameLabelConstrains() -> [NSLayoutConstraint] {
        return [
            loginNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            loginNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8)
        ]
    }
    
    private func descriptionLabelConstrains() -> [NSLayoutConstraint] {
        return [
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8)
        ]
    }
    
    private func drawSelf() {
        view.addSubview(avatarImageView)
        view.addSubview(logoutButton)
        view.addSubview(nameLabel)
        view.addSubview(loginNameLabel)
        view.addSubview(descriptionLabel)
        
        let avatarImageViewConstrains = self.avatarImageViewConstrains()
        let logoutButtonConstrains = self.logoutButtonConstrains()
        let nameLabelConstrains = self.nameLabelConstrains()
        let loginNameLabelConstrains = self.loginNameLabelConstrains()
        let descriptionLabelConstrains = self.descriptionLabelConstrains()
        
        NSLayoutConstraint.activate(
            avatarImageViewConstrains +
            logoutButtonConstrains +
            nameLabelConstrains + loginNameLabelConstrains +
            descriptionLabelConstrains
        )
    }
}
