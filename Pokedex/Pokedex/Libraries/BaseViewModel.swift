//
//  BaseViewModel.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import Foundation
import UIKit.UIViewController

protocol ViewModelProtocol {
    associatedtype Action: Equatable
    func send(_ identifier: Action)
    func present(_ identifier: Action)
    
    
}

class BaseViewModel<Action: Equatable>: ViewModelProtocol {
    weak var coordinator: Coordinator?
    weak var viewController: UIViewController?
    
    init(coordinator: Coordinator? = nil, viewController: UIViewController? = nil) {
        self.coordinator = coordinator
        self.viewController = viewController
    }
    
    func send(_ identifier: Action) {
        fatalError("send(identifier:output:) method was not implemented")
    }

    func present(_ identifier: Action) {
        fatalError("present(identifier:output:) method was not implemented")
    }

}
