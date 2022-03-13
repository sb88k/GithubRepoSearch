//
//  GithubRepoSearchInteractor.swift
//  DomainLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

public final class GithubRepoSearchInteractor: RepoSearchUseCase {
    
    public func search(with query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        
    }
    
}
