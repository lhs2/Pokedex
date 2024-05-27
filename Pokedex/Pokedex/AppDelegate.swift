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
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController: UINavigationController = .init()
        navigationController.setNavigationBarHidden(true, animated: false)

        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator = AppCoordinator.init(navigationController)
        appCoordinator?.start()
        return true
    }

}

