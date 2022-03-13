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

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appDependencies = AppDependencies()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(dependencies: appDependencies)
        window?.makeKeyAndVisible()
        
        return true
    }


}

