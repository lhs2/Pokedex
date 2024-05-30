//
//  Pokemon.swift
//  Pokedex
//
//  Created by Luiz Henrique on 29/05/2024.
//

import Foundation
import SwiftUI

class PKMPokemonList: Codable {
    var name: String?
    var url: String?
}

class Pokemon: Identifiable {
    var id: String { name! }
    var name: String?
    var imagePath: String?
    var url: String?
    
    init(name: String? = nil, imagePath: String? = nil, url: String? = nil) {
        self.name = name
        self.imagePath = imagePath
        self.url = url
    }

}

// MARK: - Pokemon
class PKMPokemon: Codable {
    
    var id: Int?
    var name: String?
    var base_experience: Int?
    var height: Int?
    var isDefault: Bool?
    var order: Int?
    var weight: Int?
    var abilities: [PKMPokemonAbility]?
    var sprites: PKMPokemonSprites?
    var stats: [PKMPokemonStat]?
    var types: [PKMPokemonType]?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


/// Pokemon Ability
class PKMPokemonAbility: Codable {
    
    var isHidden: Bool?
    var slot: Int?
    var ability: PKMAbility?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

class PKMAbility: Codable {
    
    var id: Int?
    var name: String?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

/// Pokemon Type
class PKMPokemonType: Codable {
    var slot: Int?
    var type: PKMType?
}

/// Pokemon Stat
class PKMPokemonStat: Codable {
    var stat: PKMStat?
    var effort: Int?
    var baseStat: Int?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

/// Pokemon Sprites
class PKMPokemonSprites: Codable {
    var frontDefault: String?
    var frontShiny: String?
    var frontFemale: String?
    var frontShinyFemale: String?
    var backDefault: String?
    var backShiny: String?
    var backFemale: String?
    var backShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

/// Pokemon Form Sprites
class PKMPokemonFormSprites: Codable {
    var frontDefault: String?
    var frontShiny: String?
    var backDefault: String?
    var backShiny: String?
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

// MARK: - Stats

class PKMStat: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Types

class PKMType: Codable {
    var id: Int?
    var name: String?
        
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}


