//
//  NetworkService.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

// MARK: - NetworkService

final class NetworkService {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    
}

// MARK: - NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {

    func request(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NetworkServiceError.unknownError))
            }
        }
        dataTask.resume()
    }
    
}
