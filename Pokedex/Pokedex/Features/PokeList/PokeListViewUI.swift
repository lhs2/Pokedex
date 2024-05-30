//
//  PokeListViewUI.swift
//  Pokedex
//
//  Created by Luiz Henrique on 30/05/2024.
//

import SwiftUI

struct PokeListViewUI: View {
    @State var searchInput = ""
    var viewModel: PokeListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getPokemonList(with: searchInput)) { pokemon in
                    PokeListListCell(pokemonInfo: pokemon)
                }
            }
            .searchable(text: $searchInput)
            
        }
    }
}

#Preview {
    PokeListViewUI(viewModel: PokeListViewModel(coordinator: AppCoordinator(UINavigationController()), viewController: UIViewController()))
}
