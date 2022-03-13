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
        subject.search(with: expectedQuery, page: expectedPage) { _ in
            expect.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(mockRepoSearchProvider.searchCalledCount, 1)
        XCTAssertEqual(mockRepoSearchProvider.searchQuery, expectedQuery)
        XCTAssertEqual(mockRepoSearchProvider.searchPage, expectedPage)
    }
    
    func testSearch_whenResultIsEmpty_shouldReturnNoMorePageError() {
        // given
        let expect = expectation(description: #function)
        
        mockRepoSearchProvider.searchCompletionResult = .success([])
        
        // when
        var error: Error!
        subject.search(with: UUID().uuidString, page: Int.random(in: 0 ..< Int.max)) { result in
            if case .failure(let _error) = result {
                error = _error
            }
            
            expect.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(error as! RepoSearchUseCaseError, .noMorePage)
    }
    
    func testSearch_whenRateLimited_shouldReturnRateLimitedError() {
        // given
        let expect = expectation(description: #function)
        
        mockRepoSearchProvider.searchCompletionResult = .failure(RepoSearchProviderError.rateLimited)
        
        // when
        var error: Error!
        subject.search(with: UUID().uuidString, page: Int.random(in: 0 ..< Int.max)) { result in
            if case .failure(let _error) = result {
                error = _error
            }
            
            expect.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(error as! RepoSearchUseCaseError, .rateLimited)
    }
    
    func testSearch_whenThrottled_shouldTriggerProviderOnlyOnce() {
        // given
        let expect = expectation(description: #function)
        
        mockRepoSearchProvider.searchCompletionResult = .failure(RepoSearchProviderError.rateLimited)
        
        // when
        subject.search(with: UUID().uuidString, page: Int.random(in: 0 ..< Int.max)) { _ in }
        subject.search(with: UUID().uuidString, page: Int.random(in: 0 ..< Int.max)) { _ in }
        subject.search(with: UUID().uuidString, page: Int.random(in: 0 ..< Int.max)) { _ in
            expect.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 1)
        XCTAssertEqual(mockRepoSearchProvider.searchCalledCount, 1)
    }
    
}
