//
//  GithubRepoSearchProviderTest.swift
//  DataLayerTests
//
//  Created by Sun Bin Kim on 13.03.22.
//

import XCTest
@testable import DataLayer

final class GithubRepoSearchProviderTests: XCTestCase {
    
    private var mockNetworkService: MockNetworkService!
    private var mockConfiguration: MockConfiguration!
    
    private var subject: GithubRepoSearchProvider!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkService = MockNetworkService()
        mockConfiguration = MockConfiguration()
        
        subject = GithubRepoSearchProvider(networkService: mockNetworkService, configuration: mockConfiguration)
    }
    
    override func tearDown() {
        subject = nil
        
        mockConfiguration = nil
        mockNetworkService = nil
        
        super.tearDown()
    }
    
    func testSearch_whenCalled_shouldTriggerNetworkServiceWithExpectedURL() {
        // given
        let expect = expectation(description: #function)
        
        let query = UUID().uuidString
        let page = Int.random(in: 0 ..< Int.max)
        
        mockConfiguration.githubAPIBaseURLString = UUID().uuidString
        mockConfiguration.githubRepositorySearchPath = UUID().uuidString
        
        let urlString = [mockConfiguration.githubAPIBaseURLString, mockConfiguration.githubRepositorySearchPath].joined(separator: "/")
        
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = [
            URLQueryItem(name: "accept", value: "application/vnd.github.v3+json"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        let expectedURL = urlComponents.url!
        
        mockNetworkService.requestCompletionResult = .failure(EmptyError())
        
        // when
        subject.search(with: query, page: page) { _ in
            expect.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 0.5)
        XCTAssertEqual(mockNetworkService.requestCalledCount, 1)
        XCTAssertEqual(mockNetworkService.requestURL, expectedURL)
    }
    
    func testSearch_whenSuccessFetchingDTO_shouldTriggerNetworkToFetchImageData() {
        // given
        let expect = expectation(description: #function)
        
        let dtoData = """
         {
          "total_count": 2,
          "items": [
            {
              "id": \(Int.random(in: 0 ..< Int.max)),
              "name": "Tetris",
              "full_name": "dtrupenn/Tetris",
              "html_url": "https://github.com/dtrupenn/Tetris",
              "description": "A C implementation of Tetris using Pennsim through LC4",
              "owner": {
                "login": "dtrupenn",
                "avatar_url": "/\(UUID().uuidString)",
                
                "url": "https://api.github.com/users/dtrupenn",
              }
            },
            {
              "id": \(Int.random(in: 0 ..< Int.max)),
              "name": "Tetris",
              "full_name": "dtrupenn/Tetris",
              "html_url": "https://github.com/dtrupenn/Tetris",
              "description": "A C implementation of Tetris using Pennsim through LC4",
              "owner": {
                "login": "dtrupenn",
                "avatar_url": "/\(UUID().uuidString)",
                
                "url": "https://api.github.com/users/dtrupenn",
              }
            }

          ]
        }
        """.data(using: .utf8)!
        
        mockNetworkService.requestCompletionResult = .success(dtoData)
        
        // when
        subject.search(with: UUID().uuidString, page: Int.random(in: 0 ..< Int.max)) { _ in
            expect.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 0.5)
        XCTAssertEqual(mockNetworkService.requestCalledCount, 3)
    }
}
