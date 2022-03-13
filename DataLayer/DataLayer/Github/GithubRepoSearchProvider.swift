//
//  GithubRepoSearchProvider.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation
import DomainLayer

public final class GithubRepoSearchProvider: RepoSearchProviderProtocol {
    
    public func search(with query: String, page: Int, completion: @escaping (Result<Repository, Error>) -> Void) {
        
    }
    
}
