//
//  GithubRepoSearchProvider.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation
import DomainLayer

public final class GithubRepoSearchProvider {
    
    private let networkService: NetworkServiceProtocol
    private let configuration: ConfigurationProtocol
    
    public init() {
        self.networkService = NetworkService()
        self.configuration = Configuration()
    }
    
    init(
        networkService: NetworkServiceProtocol,
        configuration: ConfigurationProtocol
    ) {
        self.networkService = networkService
        self.configuration = configuration
    }
    
}

extension GithubRepoSearchProvider: RepoSearchProviderProtocol {
                                        
    public func search(with query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let urlString = [
            configuration.githubAPIBaseURLString,
            configuration.githubRepositorySearchPath
        ].joined(separator: "/")
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "accept", value: "application/vnd.github.v3+json"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(RepoSearchProviderError.wrongConfiguration))
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()
            var lastestError: Error?
            
            var repositoriesDTO: RepositoriesDTO?
            var imageData = [Int: Data]()
            
            dispatchGroup.enter()
            self.networkService.request(with: url) { result in
                
                switch result {
                case .success(let data):
                    do {
                        repositoriesDTO = try JSONDecoder().decode(RepositoriesDTO.self, from: data)
                        
                    } catch {
                        lastestError = error
                        
                    }
                    
                case .failure(let error):
                    lastestError = error
                    
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
            
            if let error = lastestError {
                completion(.failure(error))
                return
            }
            
            guard let repositoriesDTO = repositoriesDTO else {
                completion(.failure(RepoSearchProviderError.unknownError))
                return
            }
            
            repositoriesDTO.items.forEach { item in
                
                dispatchGroup.enter()
                self.networkService.request(with: item.owner.avatarURL) { result in
                    switch result {
                    case .success(let data):
                        imageData[item.id] = data
                        
                    case .failure(let error):
                        completion(.failure(error))
                        
                    }
                    dispatchGroup.leave()
                }
                
            }
            
            dispatchGroup.notify(queue: .main) {
                let repositories = repositoriesDTO.items.map {
                    $0.asRepository(with: imageData[$0.id])
                }
                
                completion(.success(repositories))
            }

        }
        
    }

}

private extension RepositoriesDTO.RepositoryDTO {

    func asRepository(with imageData: Data?) -> Repository {
        Repository(
            avatarImageData: imageData,
            ownerName: owner.username,
            name: name,
            title: fullName,
            description: description,
            url: url
        )
    }

}
