//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Anastasiia on 01.11.2024.
//

import UIKit

final class AlertPresenter {
    
    private weak var delegate: UIViewController?
    
    init(delegate: UIViewController? = nil) {
        self.delegate = delegate
    }
}

extension AlertPresenter: AlertPresenterProtocol {
    
    func showAlert(result: AlertModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in result.completion?() }
        alert.addAction(action)
        
        if let secondButtonText = result.secondButtonText {
            let action = UIAlertAction(title: secondButtonText, style: .default) { _ in result.secondCompletion?() }
            alert.addAction(action)
        }
        
        alert.view.accessibilityIdentifier = result.identifier
        delegate?.present(alert, animated: true, completion: nil)
    }
}
