//
//  Pagination.swift
//  Pokedex
//
//  Created by Luiz Henrique on 30/05/2024.
//

import Foundation

struct Pagination< T:Codable >: Codable {
    var count: Int?
    var results: [T]?
}
