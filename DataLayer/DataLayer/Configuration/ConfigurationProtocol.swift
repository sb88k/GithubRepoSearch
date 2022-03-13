//
//  ConfigurationProtocol.swift
//  DataLayer
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation

protocol ConfigurationProtocol {
    
    var githubAPIBaseURLString: String { get }
    
    var githubRepositorySearchPath: String { get }
    
}
