//
//  MockRepoSearchProvider.swift
//  DomainLayerTests
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation
@testable import DomainLayer

final class MockRepoSearchProvider: RepoSearchProviderProtocol {
    
    private(set) var searchCalledCount = 0
    private(set) var searchQuery: String!
    private(set) var searchPage: Int!
    
    var searchCompletionResult: Result<[Repository], Error>!
    
    func search(with query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        searchCalledCount += 1
        searchQuery = query
        searchPage = page
        
        completion(searchCompletionResult)
    }
    
}
