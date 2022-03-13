//
//  NetworkServiceProtocol.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

// MARK: - NetworkServiceProtocol

public protocol NetworkServiceProtocol {
    func request(with url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

// MARK: - NetworkServiceError

enum NetworkServiceError: Error {
    case unknownError
}
