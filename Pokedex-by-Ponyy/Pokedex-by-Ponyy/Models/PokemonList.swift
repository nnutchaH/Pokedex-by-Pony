//
//  PokemonData.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 10/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PokemonData]
}

struct PokemonData: Codable {
    let name: String
    let url: String
}
