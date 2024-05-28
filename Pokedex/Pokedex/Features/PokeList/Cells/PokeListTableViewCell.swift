//
//  PokeListTableViewCell.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit

class PokeListTableViewCell: UITableViewCell {
    static var identifier = "PokeListTableViewCell"
    
    var pokemonName: String = "MISSINGNO"
    
    var loadedImage: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        var content = defaultContentConfiguration().updated(for: state)
        content.imageProperties.reservedLayoutSize = CGSize(width: 80, height: 80)
        content.image = loadedImage
        content.text = pokemonName
        content.textProperties.alignment = .center
        if let pokeFont = UIFont(name: "Pokmon-DS-Font", size: 40) {
            content.textProperties.font = pokeFont
        }
        
        contentConfiguration = content
    }
}
