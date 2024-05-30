//
//  PokeListListCell.swift
//  Pokedex
//
//  Created by Luiz Henrique on 30/05/2024.
//

import SwiftUI

struct PokeListListCell: View {
    var pokemonInfo: Pokemon
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: getImagePath()) ) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .padding(.trailing, 20)
            Text(getPokemonName())
                .font(getFont())
        }
    }
    
    func getImagePath() -> String {
        return pokemonInfo.imagePath ?? ""
    }
    
    func getPokemonName() -> String {
        return pokemonInfo.name?.uppercased() ?? "MISSIGNO"
    }

    func getFont() -> Font {
        guard let pokeFont = UIFont(name: "Pokmon-DS-Font", size: 25) else {
            return .title
        }
        return Font(pokeFont)
    }
}

#Preview {
    PokeListListCell(pokemonInfo: Pokemon(name: "Ditto", imagePath: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png", url: "https://pokeapi.co/api/v2/pokemon/132/"))
}
