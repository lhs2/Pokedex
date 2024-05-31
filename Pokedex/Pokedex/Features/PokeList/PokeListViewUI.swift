//
//  PokeListViewUI.swift
//  Pokedex
//
//  Created by Luiz Henrique on 30/05/2024.
//

import SwiftUI
import Swinject

struct PokeListViewUI: View {
    @State var searchInput = ""
    var viewModel: PokeListViewModel
    var resolver: Resolver?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.getPokemonList(with: searchInput)) { pokemon in
                    NavigationLink (destination: PokeDetailsView(pokemonInfo: viewModel.getPokemonDetail(input: pokemon.url), resolver: resolver) ) {
                        PokeListListCell(pokemonInfo: pokemon)
                    }
                }
                if viewModel.isMoreDataAvailable {
                    ZStack(alignment: .center) {
                        switch viewModel.paginationState {
                        case .isLoading:
                            ProgressView()
                        case .idle:
                            EmptyView()
                        }
                    }
                    .frame(height: 50)
                    .onAppear {
                        //viewModel.requestList()
                    }
                }
            }
            .searchable(text: $searchInput)
            
            
        }
    }
}

#Preview {
    PokeListViewUI(viewModel: PokeListViewModel(coordinator: AppCoordinator(UINavigationController()), viewController: UIViewController()))
}
