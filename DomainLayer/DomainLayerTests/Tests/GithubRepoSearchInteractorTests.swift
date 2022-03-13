//
//  GithubRepoSearchInteractorTests.swift
//  DomainLayerTests
//
//  Created by Sun Bin Kim on 13.03.22.
//

import XCTest
@testable import DomainLayer

final class GithubRepoSearchInteractorTests: XCTestCase {
    
    private var mockRepoSearchProvider: MockRepoSearchProvider!
    
    private var subject: GithubRepoSearchInteractor!
    
    override func setUp() {
        super.setUp()
        
        mockRepoSearchProvider = MockRepoSearchProvider()
        
        subject = GithubRepoSearchInteractor(githubRepoSearchProvider: mockRepoSearchProvider)
    }
    
    override func tearDown() {
        subject = nil
        
        mockRepoSearchProvider = nil
        
        super.tearDown()
    }
    
    func testSearch_whenCalled_shouldTriggerProviderWithExpectedParameters() {
        // given
        let expect = expectation(description: #function)
        
        let expectedQuery = UUID().uuidString
        let expectedPage = Int.random(in: 0 ..< Int.max)
        
        mockRepoSearchProvider.searchCompletionResult = .failure(EmptyError())
        
        // when
        subject.search(with: expectedQuery, page: expectedPage) { _Arg in
            expect.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 0.5)
        XCTAssertEqual(mockRepoSearchProvider.searchCalledCount, 1)
        XCTAssertEqual(mockRepoSearchProvider.searchQuery, expectedQuery)
        XCTAssertEqual(mockRepoSearchProvider.searchPage, expectedPage)
    }
    
}
