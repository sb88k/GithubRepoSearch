//
//  RepoSearchUseCase.swift
//  DomainLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

public protocol RepoSearchUseCase {
    
    func search(with query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void)
    
}

public enum RepoSearchUseCaseError: Error {
    
    case rateLimited
    case noMorePage
    
}
