//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Anastasiia on 08.10.2024.
//

import UIKit
@preconcurrency import WebKit

final class WebViewViewController: UIViewController, WebViewViewControllerProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private var webView: WKWebView!
    @IBOutlet var progressView: UIProgressView!
    
    // MARK: - Public Properties
    weak var delegate: WebViewViewControllerDelegate?
    var presenter: WebViewPresenterProtocol?
    
    // MARK: - Private Properties
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        presenter?.viewDidLoad()
        
        progressView.progressTintColor = .ypBlack
        
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self else { return }
                 self.presenter?.didUpdateProgressValue(self.webView.estimatedProgress)
             })
    }
    
    // MARK: - Public Methods
    func load(request: URLRequest) {
        webView.load(request)
    }
    
    func setProgressValue(_ newValue: Float) {
        progressView.progress = newValue
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        progressView.isHidden = isHidden
    }
    
}

extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if let url = navigationAction.request.url {
            return presenter?.code(from: url)
        }
        
        return nil
    }
}
