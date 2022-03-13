//
//  Repository.swift
//  DomainLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

public struct Repository {
    
    public let avatarImageData: Data?
    public let ownerName: String
    public let name: String
    public let title: String
    public let description: String?
    public let url: URL
    
    public init(
        avatarImageData: Data?,
        ownerName: String,
        name: String,
        title: String,
        description: String?,
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
