//
//  AppDelegate.swift
//  circlescore
//
//  Created by Amish Patel on 20/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController: UINavigationController {
        return self.window?.rootViewController as! UINavigationController
    }

    private lazy var appCoordinator: Coordinator = AppCoordinator(router: Router(rootController: self.rootViewController))
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.appCoordinator.start()
        
        return true
    }
}

