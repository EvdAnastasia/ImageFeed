//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Anastasiia on 01.11.2024.
//

import Foundation

struct AlertModel {
    let identifier: String
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}
