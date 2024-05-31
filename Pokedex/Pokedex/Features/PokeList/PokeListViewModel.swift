//
//  PokeListViewModel.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import SwiftUI

final class PokeListViewModel: PokeListViewModelProtocol, ObservableObject, Identifiable {
    var worker: PokeListWorkerProtocol?
    @Published var pokemonList: [Pokemon] = []
    var isMoreDataAvailable: Bool = false
    @State var paginationState: PaginationState = .idle
    var limit = 151
    var offset = 0
    
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
            paginationState = .idle
            isMoreDataAvailable = true
        }
    }
    
    func requestList() {
        paginationState = .isLoading
        isMoreDataAvailable = false
        let newList = worker?.requestList(offset: offset, limit: limit) ?? []
        let parsedList = newList.compactMap({ item in
            let parsedItem = Pokemon(name: item.name, imagePath: nil, url: item.url)
            if let pokeID = item.url?.components(separatedBy: "/").dropLast().last {
                parsedItem.imagePath = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokeID).png"
            }
            return parsedItem
        })
        pokemonList.append(contentsOf: parsedList)
        offset = pokemonList.count
        present(.requestList)
    }
    
    func getPokemonDetail(input: String?)-> PKMPokemon {
        let missigno = PKMPokemon()
        missigno.name = "MISSINGNO"
        
        guard let input = input else {
            return missigno
        }
        
        let pokeInfo = worker?.requestPokemonBy(input: input)
        
        guard let pokeInfo = pokeInfo else {
            return missigno
        }
        
        return pokeInfo
    }

    
    private func requestPokemonBy(pokedexId: Int) {
        print("Present Pokemon Details \(pokedexId)")
    }
    
    func getPokemonList(with searchInput: String)-> [Pokemon] {
        if searchInput == "" {
            return pokemonList
        }
        return pokemonList.filter {  $0.name?.uppercased().contains(searchInput.uppercased()) ?? false }
    }
}
