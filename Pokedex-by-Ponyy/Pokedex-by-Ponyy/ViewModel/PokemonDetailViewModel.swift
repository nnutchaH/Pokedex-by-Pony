//
//  PokemonDetailViewModel.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 16/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Foundation

class PokemonDetailViewModel {
    
    var request = PokemonRequest()
    var reloadDetail = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    var pokemonData: PokemonData!
    var pokemonDetail: PokemonDetail! {
        didSet { reloadDetail() } }
    
    func getPokemonDetailData() {
        self.request.requestPokemonDetail(name: pokemonData.name ) { result in
            switch result {
            case .success(let data):
                self.pokemonDetail = data.self
            case .failure(let error):
                print("error: \(error)")
            }
            
        }
    }
    
    func fetchPokemonListData() {
        getPokemonDetailData()
    }

}
