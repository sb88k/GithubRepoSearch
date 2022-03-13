//
//  ViewControllerDependencies.swift
//  Dependencies
//
//  Created by Sun Bin Kim on 13.03.22.
//

import DomainLayer

public protocol ViewControllerDependencies {
    
    var repoSearchUseCase: RepoSearchUseCase { get }
    
}
