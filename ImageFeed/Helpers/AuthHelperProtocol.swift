//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by Anastasiia on 19.11.2024.
//

import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest?
    func code(from url: URL) -> String?
}
