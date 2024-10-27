//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Anastasiia on 27.10.2024.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    
    // MARK: - Private Properties
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    // MARK: - Public Methods
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.animate()
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
