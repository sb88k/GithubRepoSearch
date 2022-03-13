//
//  GithubRepoSearchInteractor.swift
//  DomainLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

public final class GithubRepoSearchInteractor {
    
    private var throttledTask: DispatchWorkItem?
    
    private let githubRepoSearchProvider: RepoSearchProviderProtocol
    
    public init(githubRepoSearchProvider: RepoSearchProviderProtocol) {
        self.githubRepoSearchProvider = githubRepoSearchProvider
    }
    
}

extension GithubRepoSearchInteractor: RepoSearchUseCase {
    
    public func search(with query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        throttledTask?.cancel()
        
        throttledTask = DispatchWorkItem { [weak self] in
            if self?.throttledTask?.isCancelled == true {
                return
            }
            
            self?.githubRepoSearchProvider.search(with: query, page: page) { result in
                switch result {
                case .success(let repositories):
                    if repositories.count == 0 {
                        completion(.failure(RepoSearchUseCaseError.noMorePage))
                    } else {
                        completion(.success(repositories))
                    }
                    
                case .failure(let error):
                    if case RepoSearchProviderError.rateLimited = error {
                        completion(.failure(RepoSearchUseCaseError.rateLimited))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        guard let throttledTask = throttledTask else { return }
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.5, execute: throttledTask)
    }
    
}
