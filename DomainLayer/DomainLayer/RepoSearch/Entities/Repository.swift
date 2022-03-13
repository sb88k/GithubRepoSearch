//
//  Repository.swift
//  DomainLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

public struct Repository {
    
    let avatarImageData: Data?
    let ownerName: String
    let name: String
    let title: String
    let description: String
    let url: URL
    
    public init(
        avatarImageData: Data?,
        ownerName: String,
        name: String,
        title: String,
        description: String,
        url: URL
    ) {
        self.avatarImageData = avatarImageData
        self.ownerName = ownerName
        self.name = name
        self.title = title
        self.description = description
        self.url = url
    }
    
}
