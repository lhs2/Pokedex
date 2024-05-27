//
//  PokeListViewModel.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import Foundation

final class PokeListViewModel: PokeListViewModelProtocol {
    override func send(_ identifier: PokeListViewModelActionIdentifier) {
        switch identifier {
            case .goToDetailsBy(let pokedexId):
            print("Send Pokemon Details \(pokedexId)")
        }
    }
    
    override func present(_ identifier: PokeListViewModelActionIdentifier) {
        switch identifier {
        case .goToDetailsBy(let pokedexId):
            requestPokemonBy(pokedexId: pokedexId)
        }
    }
    
    private func requestPokemonBy(pokedexId: Int) {
        print("Present Pokemon Details \(pokedexId)")
    }
}
