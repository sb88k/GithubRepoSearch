//
//  RepositoriesDTO.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

struct RepositoriesDTO: Decodable {
    
    let totalCount: Int
    let items: [RepositoryDTO]
    
}

extension RepositoriesDTO {
    
    struct RepositoryDTO: Decodable {
        
        let name: String
        let fullName: String
        let url: URL
        let description: String
        let owner: OwnerDTO
        
        enum CodingKeys: String, CodingKey {
            case name
            case fullName = "full_name"
            case url = "html_url"
            case description
            case owner
        }
    }
    
}

extension RepositoriesDTO.RepositoryDTO {
    
    struct OwnerDTO: Decodable {
        
        let username: String
        let avatarURL: URL
        let url: URL
        
        enum CodingKeys: String, CodingKey {
            case username = "login"
            case avatarURL = "avatar_url"
            case url
        }
        
    }
    
}
