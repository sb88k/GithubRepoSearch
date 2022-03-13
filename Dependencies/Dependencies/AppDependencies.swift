//
//  AppDependencies.swift
//  Dependencies
//
//  Created by Sun Bin Kim on 13.03.22.
//

import Foundation
import DataLayer
import DomainLayer

public final class AppDependencies: AppDependenciesComposition {
    
    private let githubRepoSearchProvider = GithubRepoSearchProvider()
    
    public lazy var repoSearchUseCase: RepoSearchUseCase = {
        GithubRepoSearchInteractor(githubRepoSearchProvider: githubRepoSearchProvider)
    }()
    
    
    public init() {}
    
}
