//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func start()
}

class AppCoordinator: AppCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        presentHome()
    }
    
    private func presentHome() {
        let pokeListCoordinator = PokeListCoordinator(navigationController)
        pokeListCoordinator.start()
        childCoordinators.append(pokeListCoordinator)
    }
    
}
