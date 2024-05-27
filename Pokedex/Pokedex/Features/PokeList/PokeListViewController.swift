//
//  PokeListViewController.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit

final class PokeListViewController: UIViewController {
    var viewModel: PokeListViewModelProtocol?
    var coordinator: PokeListCoordinatorProtocol?
    
    var pokeListView = PokeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view = pokeListView
    }
    
}
