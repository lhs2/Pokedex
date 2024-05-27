//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Luiz Henrique on 26/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let navigationController: UINavigationController = .init()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

