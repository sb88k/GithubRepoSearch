//
//  Configuration.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

struct Configuration: ConfigurationProtocol {
    
    var githubAPIBaseURLString: String {
        "https://api.github.com"
    }
    
    var githubRepositorySearchPath: String {
        "search/repositories"
    }
    
}
