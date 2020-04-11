//
//  PokemonDetail.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 10/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let base_experience: Int
    let sprites: PokemonSprites
    let stats:[PokemonStats]
}

struct PokemonSprites: Codable {
    let front_shiny: String
    let front_default: String
}

struct PokemonStats: Codable {
    let base_stat: Int
    let effort: Int
    let stat: nameStat
}

struct nameStat: Codable {
    let name: String
    let url: String
}
