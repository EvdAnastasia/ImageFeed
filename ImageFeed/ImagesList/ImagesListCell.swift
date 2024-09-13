//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Anastasiia on 09.09.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var dateLabelView: UIView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var likeButton: UIButton!
    
    func configCell(image: UIImage, date: String, isLiked: Bool) {
        cellImage.image = image
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
