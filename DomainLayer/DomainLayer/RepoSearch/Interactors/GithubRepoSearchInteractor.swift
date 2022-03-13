//
//  GithubRepoSearchInteractor.swift
//  DomainLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

public final class GithubRepoSearchInteractor {
    
    private let githubRepoSearchProvider: RepoSearchProviderProtocol
    
    public init(githubRepoSearchProvider: RepoSearchProviderProtocol) {
        self.githubRepoSearchProvider = githubRepoSearchProvider
    }
    
}

extension GithubRepoSearchInteractor: RepoSearchUseCase {
    
    public func search(with query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        githubRepoSearchProvider.search(with: query, page: page, completion: completion)
    }
    
}
