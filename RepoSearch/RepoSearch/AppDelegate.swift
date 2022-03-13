//
//  AppDelegate.swift
//  RepoSearch
//
//  Created by Sun Bin Kim on 13.03.22.
//

import UIKit
import Dependencies

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var appCoordinator: AppCoordinator?

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let appCoordinator = AppCoordinator(dependencies: AppDependencies())
        self.appCoordinator = appCoordinator
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
        
        return true
    }


}

