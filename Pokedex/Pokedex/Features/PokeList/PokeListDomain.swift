//
//  PokeListDomain.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import Foundation

typealias PokeListViewModelProtocol = BaseViewModel<PokeListViewModelActionIdentifier>

enum PokeListViewModelActionIdentifier: Equatable {
    case requestList
    case goToDetailsBy(_ pokedexNumber: Int)
    
    static func == (lhs: PokeListViewModelActionIdentifier, rhs: PokeListViewModelActionIdentifier) -> Bool {
        switch (lhs, rhs) {
        case (.requestList, .requestList):
            return true
        case (.goToDetailsBy(let pokedexNumber1), .goToDetailsBy(let pokedexNumber2)):
            return pokedexNumber1 == pokedexNumber2
        default:
            return false
        }
    }
}
