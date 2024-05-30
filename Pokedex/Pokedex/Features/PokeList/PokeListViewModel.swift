//
//  PokeListViewModel.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import Foundation

final class PokeListViewModel: PokeListViewModelProtocol, ObservableObject, Identifiable {
    var worker: PokeListWorkerProtocol?
    var pokemonList: [Pokemon] = []
    
    override func send(_ identifier: PokeListViewModelActionIdentifier) {
        switch identifier {
        case .goToDetailsBy(let pokedexId):
            print("Send Pokemon Details \(pokedexId)")
        case .requestList:
            requestList()
        }
    }
    
    override func present(_ identifier: PokeListViewModelActionIdentifier) {
        switch identifier {
        case .goToDetailsBy(let pokedexId):
            requestPokemonBy(pokedexId: pokedexId)
        case .requestList:
            print(1)
            
        }
    }
    
    private func requestList() {
        let newList = worker?.requestList(offset: 0, limit: 30) ?? []
        let parsedList = newList.compactMap({ item in
            let parsedItem = Pokemon(name: item.name, imagePath: nil, url: item.url)
            if let pokeID = item.url?.components(separatedBy: "/").dropLast().last {
                parsedItem.imagePath = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeID).png"
            }
            return parsedItem
        })
        pokemonList.append(contentsOf: parsedList)
        present(.requestList)
    }
    
    private func requestPokemonBy(pokedexId: Int) {
        print("Present Pokemon Details \(pokedexId)")
    }
    
    func getPokemonList(with searchInput: String)-> [Pokemon] {
        if searchInput == "" {
            return pokemonList
        }
        return pokemonList.filter { $0.name?.contains(searchInput.uppercased()) ?? false }
    }
}
