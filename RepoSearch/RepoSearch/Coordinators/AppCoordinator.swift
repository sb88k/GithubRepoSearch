//
//  AppCoordinator.swift
//  RepoSearch
//
//  Created by Sun Bin Kim on 13.03.22.
//

import UIKit
import DomainLayer
import Dependencies

final class AppCoordinator {
    
    private var navigationController: UINavigationController?
    private var viewController: ViewController?
    
    private let dependencies: AppCoordinatorDependencies
    
    init(dependencies: AppCoordinatorDependencies) {
        self.dependencies = dependencies
    }
    
    func start() -> UIViewController {
        
        let viewController = ViewController(dependencies: dependencies)
        
        self.viewController = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        
        return navigationController
        
    }
    
}
