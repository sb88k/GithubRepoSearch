//
//  RepoSearchProviderProtocol.swift
//  DomainLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

public protocol RepoSearchProviderProtocol {
    
    func search(with query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void)
    
}

public enum RepoSearchProviderError: Error {
    
    case wrongConfiguration
    case unknownError
    
}
