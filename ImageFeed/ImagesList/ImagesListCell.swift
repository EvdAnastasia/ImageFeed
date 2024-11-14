//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Anastasiia on 09.09.2024.
//

import UIKit
import Kingfisher

final class ImagesListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var dateLabelView: UIView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var likeButton: UIButton!
    
    // MARK: - Private Properties
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - Overrides Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Отменяем загрузку, чтобы избежать багов при переиспользовании ячеек
        cellImage.kf.cancelDownloadTask()
    }
    
    // MARK: - Public Methods
    func configCell(imageURL: String, date: String, isLiked: Bool) {
        guard
            let url = URL(string: imageURL)
        else { return }
        cellImage.kf.indicatorType = .activity
        cellImage.kf.setImage(with: url,
                              placeholder: UIImage(named: "PhotoPlaceholder")
        )
        
        dateLabel.text = date
        
        let likeImage = isLiked ? UIImage(named: "LikeButtonOn") : UIImage(named: "LikeButtonOff")
        likeButton.setImage(likeImage, for: .normal)
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        let colorTop =  UIColor(red: 0.10, green: 0.11, blue: 0.13, alpha: 0).cgColor
        let colorBottom = UIColor(red: 0.10, green: 0.11, blue: 0.13, alpha: 0.2).cgColor
        gradientLayer.frame.size = dateLabelView.frame.size
        gradientLayer.colors = [colorTop, colorBottom]
        dateLabelView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
