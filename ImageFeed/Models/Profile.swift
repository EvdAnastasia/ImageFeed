//
//  Profile.swift
//  ImageFeed
//
//  Created by Anastasiia on 28.10.2024.
//

public struct Profile {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
    
    var name: String {
        var nameString = firstName
        
        if let lastName {
            nameString += " \(lastName)"
        }
        
        return nameString
    }
    
    var loginName: String {
        return "@\(username)"
    }
}
