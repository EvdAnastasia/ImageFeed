//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Anastasiia on 08.10.2024.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
