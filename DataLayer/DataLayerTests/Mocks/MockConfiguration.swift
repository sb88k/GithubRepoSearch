//
//  MockConfiguration.swift
//  DataLayerTests
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation
@testable import DataLayer

final class MockConfiguration: ConfigurationProtocol {
    
    var githubAPIBaseURLString: String = ""
    
    var githubRepositorySearchPath: String = ""
    
}
