//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Anastasiia on 18.11.2024.
//

import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
}
