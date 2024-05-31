//
//  PokeDetailsDomain.swift
//  Pokedex
//
//  Created by Luiz Henrique on 31/05/2024.
//

import Foundation

typealias PokeDetailsViewModelProtocol = BaseViewModel<PokeDetailsViewModelActionIdentifier>

enum PokeDetailsViewModelActionIdentifier: Equatable {
    case favoritePokemon(pokeID: Int)
    
    static func == (lhs: PokeDetailsViewModelActionIdentifier, rhs: PokeDetailsViewModelActionIdentifier) -> Bool {
        switch (lhs, rhs) {
        case (.favoritePokemon(let pokemonID1), .favoritePokemon(let pokemonID2)):
            return pokemonID1 == pokemonID2
        }
    }
}
