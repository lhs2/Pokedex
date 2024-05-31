//
//  PokeDetailsViewModel.swift
//  Pokedex
//
//  Created by Luiz Henrique on 31/05/2024.
//

import Foundation

final class PokeDetailsViewModel: PokeDetailsViewModelProtocol, ObservableObject, Identifiable {
    var worker: PokeDetailsWorker?
    
    override func send(_ identifier: PokeDetailsViewModelActionIdentifier) {
        switch identifier {
        case .favoritePokemon(let pokemonID):
            print(pokemonID)
        }
    }
    
    override func present(_ identifier: PokeDetailsViewModelActionIdentifier) {
        switch identifier {
        case .favoritePokemon(let pokemonID):
            print(pokemonID)
        }
    }
    
    func postFavoritePokemon(pokemon: PKMPokemon?) {
        guard let pokemon = pokemon else {
            return
        }
        _ = worker?.postFavoritePokemon(pokemon: pokemon)
    }
}
