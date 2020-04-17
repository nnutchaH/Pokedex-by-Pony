//
//  PokemonListViewModel.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 16/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Foundation

class PokemonListViewModel {
    
    let request = PokemonRequest()
    var offset = 0
    var limit = 30
    var page = 0
    var inSearchMode = false
    var pokemonData: [PokemonData] = [] {
        didSet { reloadList() } }
    var filterPokemonData = [PokemonData]()
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    
    func getPokemonListData() {
        self.request.requestPokemonList(offset: offset, limit: limit) { result in
            switch result {
            case .success(let data):
                self.pokemonData.append(contentsOf: data.results)
                self.page += 1
                self.offset = self.page * self.limit
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func searchBar(from searchText: String) {
        filterPokemonData = pokemonData.filter ({ $0.name.range(of: searchText.lowercased()) != nil })
    }
    
    func fetchPokemonListData() {
        pokemonData = []
        offset = 0
        limit = 30
        getPokemonListData()
    }
}
