//
//  PokeListViewController.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit
import SwiftUI

final class PokeListViewController: UIViewController {
    var viewModel: PokeListViewModel?
    var coordinator: PokeListCoordinatorProtocol?
    
    var pokeListView: PokeListViewUI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    private func setupUI() {
        if let pokeListView = pokeListView {
            let childView = UIHostingController(rootView: pokeListView)
            addChild(childView)
            childView.view.frame = view.bounds
            view.addSubview(childView.view)
            childView.didMove(toParent: self)
        }
        viewModel?.send(.requestList)
    }
}
