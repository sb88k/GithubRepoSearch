//
//  MockNetworkService.swift
//  DataLayerTests
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation
@testable import DataLayer

final class MockNetworkService: NetworkServiceProtocol {
    
    private(set) var requestCalledCount = 0
    private(set) var requestURL: URL!
    
    var requestCompletionResult: Result<Data, Error>!
    
    func request(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        requestCalledCount += 1
        requestURL = url
        
        completion(requestCompletionResult)
    }
    
}
