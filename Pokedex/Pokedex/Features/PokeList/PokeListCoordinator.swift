//
//  PokeListCoordinator.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit
import Swinject

protocol PokeListCoordinatorProtocol: Coordinator {
    func start()
}

class PokeListCoordinator: PokeListCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var resolver: Resolver?
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = PokeListViewController()
        let viewModel = PokeListViewModel(coordinator: self, viewController: vc)
        viewModel.worker = PokeListWorker(resolver: resolver)
        let view = PokeListViewUI(viewModel: viewModel)
        vc.pokeListView = view
        vc.viewModel = viewModel
        vc.coordinator = self
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
}
