//
//  PokeDetailsView.swift
//  Pokedex
//
//  Created by Luiz Henrique on 30/05/2024.
//

import SwiftUI

struct PokeDetailsView: View {
    var pokemonInfo: PKMPokemon
    
    var body: some View {
        AsyncImage(url: URL(string: getPokemonImage())){ image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 150, height: 150)
        Form {
            Section(header: Text(getPokemonName())) {
                LabeledContent("Pokémon ID", value: getPokedexID())
                LabeledContent("Type(s)") {
                    HStack {
                        ForEach(getPokemonTypes(), id: \.self) { types in
                            Image(types)
                                .resizable()
                                .frame(width: 80, height: 40)
                        }
                    }
                }
                LabeledContent("Height", value: getPokemonHeight())
                LabeledContent("Width", value: getPokemonWeight())
                LabeledContent("Base Experience", value: getPokemonBaseExperience())
                LabeledContent("Abilities", value: getPokemonAbilities())
            }
        }
    }
    
    private func getPokemonImage() -> String {
        return pokemonInfo.sprites?.frontDefault ?? ""
    }
    
    private func getPokemonName() -> String {
        return pokemonInfo.name ?? "????????"
    }
    
    private func getPokedexID() -> String {
        return "#\(pokemonInfo.id ?? 0)"
    }
    
    private func getPokemonHeight() -> String {
        return "\(pokemonInfo.height ?? 0) dm"
    }
    
    private func getPokemonWeight() -> String {
        return "\(pokemonInfo.weight ?? 0) hg"
    }
    
    private func getPokemonBaseExperience() -> String {
        return "\(pokemonInfo.base_experience ?? 0)"
    }
    
    private func getPokemonAbilities() -> String {
        guard let abilities = pokemonInfo.abilities else {
            return "No Ability"
        }
        let abilitiesArray = abilities.compactMap{  $0.ability?.name?.uppercased() }
        return abilitiesArray.joined(separator: " \n")
    }
    
    private func getPokemonTypes() -> [String] {
        guard let typesArray = pokemonInfo.types else {
            return []
        }
        return typesArray.compactMap{ $0.type?.name }
    }
}

#Preview {
    PokeDetailsView(pokemonInfo: PKMPokemon())
}
