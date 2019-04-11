//
//  AppDelegate.swift
//  Instagram_Boomerang
//
//  Created by Boominadha Prakash on 09/04/19.
//  Copyright © 2019 DrawRect. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .white
        return window
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpRootScene()
        return true
    }
    
}

extension AppDelegate {
    func setUpRootScene() {
        let cc = IGCameraController()
        let navController = UINavigationController(rootViewController: cc)
        navController.isNavigationBarHidden = true
        window.rootViewController = navController
    }
}
