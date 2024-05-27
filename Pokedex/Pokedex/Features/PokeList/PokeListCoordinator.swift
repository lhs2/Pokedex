//
//  PokeListCoordinator.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit

protocol PokeListCoordinatorProtocol: Coordinator {
    func start()
}

class PokeListCoordinator: PokeListCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = PokeListViewController()
        let viewModel = PokeListViewModel(coordinator: self, viewController: vc) 
        vc.viewModel = viewModel
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
}
