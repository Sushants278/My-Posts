//
//  AppDelegate.swift
//  My Posts
//
//  Created by Sushant Shinde on 04.09.23.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = LoginViewController()
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        return true
    }
}

