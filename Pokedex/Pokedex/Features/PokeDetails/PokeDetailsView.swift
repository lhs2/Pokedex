//
//  PokeDetailsView.swift
//  Pokedex
//
//  Created by Luiz Henrique on 30/05/2024.
//

import SwiftUI
import Swinject

struct PokeDetailsView: View {
    init(pokemonInfo: PKMPokemon, resolver: Resolver?) {
        self.pokemonInfo = pokemonInfo
        viewModel.resolver = resolver
        viewModel.worker = PokeDetailsWorker(resolver: resolver)
    }
    var pokemonInfo: PKMPokemon
    var viewModel: PokeDetailsViewModel = PokeDetailsViewModel()
    var resolver: Resolver?
    
    var body: some View {
        LazyVStack {
            Text(getPokemonName()).font(getFont())
            AsyncImage(url: URL(string: getPokemonImage())){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
        }
        Form {
            Section(header: Text("Pokémon Information")) {
                LabeledContent("Pokémon ID", value: getPokedexID()).font(getFont())
                LabeledContent("Type(s)") {
                    HStack {
                        ForEach(getPokemonTypes(), id: \.self) { types in
                            Image(types)
                                .resizable()
                                .frame(width: 80, height: 40)
                        }
                    }
                }.font(getFont())
                LabeledContent("Height", value: getPokemonHeight()).font(getFont())
                LabeledContent("Width", value: getPokemonWeight()).font(getFont())
                LabeledContent("Base Experience", value: getPokemonBaseExperience()).font(getFont())
                LabeledContent("Abilities", value: getPokemonAbilities()).font(getFont())
                Button("Favorite this pokemon", action: {
                    viewModel.postFavoritePokemon(pokemon: pokemonInfo)
                }).font(getFont())
            }
        }
    }
    
    private func getPokemonImage() -> String {
        return pokemonInfo.sprites?.frontDefault ?? ""
    }
    
    private func getPokemonName() -> String {
        return pokemonInfo.name?.uppercased() ?? "????????"
    }
    
    private func getPokedexID() -> String {
        return "#\(pokemonInfo.id ?? 0)"
    }
    
    private func getPokemonHeight() -> String {
        if var height = pokemonInfo.height {
            height *= 10
            return "\(height) cm"
        }
        return "NO INFO"
    }
    
    private func getPokemonWeight() -> String {
        if var weight = pokemonInfo.weight {
            weight *= 100
            return "\(weight) g"
        }
        return "NO INFO"
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
    
    func getFont() -> Font {
        guard let pokeFont = UIFont(name: "Pokmon-DS-Font", size: 30) else {
            return .title
        }
        return Font(pokeFont)
    }
}

#Preview {
    PokeDetailsView(pokemonInfo: PKMPokemon(), resolver: Container() )
}
