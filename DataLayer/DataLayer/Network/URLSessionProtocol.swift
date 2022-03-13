//
//  URLSessionProtocol.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

// MARK: - URLSessionProtocol

public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

// MARK: - URLSession + URLSessionProtocol

extension URLSession: URLSessionProtocol {}
