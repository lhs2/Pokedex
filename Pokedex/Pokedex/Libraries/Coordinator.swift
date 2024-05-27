//
//  Coordinator.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? {get set}
    var navigationController: UINavigationController {get set}
    var childCoordinators: [Coordinator] {get set}
    func start()
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

//MARK: - Coordinator Output

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
