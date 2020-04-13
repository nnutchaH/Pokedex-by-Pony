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
    
    func setupPokemonListUI(pokemonList: PokemonData,pokemonId: Int) {
        
        pokemonName.text = pokemonList.name
        
        let urlImage = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + "\(pokemonId).png")
        pokemonImage.kf.setImage(with: urlImage)
        
    }
    
}
