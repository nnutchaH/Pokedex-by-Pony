//
//  PokemonListViewModel.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 16/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Foundation

class PokemonListViewModel {
    
    var request = PokemonRequest()
    var offset = 0
    var limit = 30
    var page = 0
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    var pokemonData: [PokemonData] = [] {
        didSet { reloadList() } }
    var filterPokemonData = [PokemonData]()
    var inSearchMode = false
    
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
