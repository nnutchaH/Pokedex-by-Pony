//
//  PokemonListTableViewCell.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 10/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

class PokemonListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    func setupPokemonListUI(pokemonList: PokemonData) {
        let url = URL(string: pokemonList.url)
        pokemonImage.kf.setImage(with: url)
        pokemonName.text = pokemonList.name
    }
    
}
