//
//  ViewController.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 10/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var searchPokemon: UISearchBar!
    @IBOutlet weak var pokemonListTableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    private var filteredPokemonListData: [PokemonData] = [] {
        didSet { didSetfilteredPokemonListData(oldValue) } }
    private var pokemonListData: [PokemonData] = [] {
        didSet { didSetPokemonListData(oldValue) } }
    
    var inSearchMode = false
    let pokemonRequest = PokemonRequest()
    var offset = 0
    var limit = 30
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonRequest
            .requestPokemonList(offset: offset, limit: limit, callback: { [weak self] in
                self?.handleResponse(result: $0) })
    }
    
    private func handleResponse(result: Result<PokemonList, Error>) {
        switch result {
        case .success(let data):
            self.pokemonListData.append(contentsOf: data.results)
            self.pokemonListTableView.reloadData()
            self.loadingView.isHidden = true
            self.page += 1
            self.offset = page * limit
        case .failure(let error):
            print("error: \(error)")
        }
    }
    
    private func didSetPokemonListData(_ oldValue: [PokemonData]) {
        pokemonListTableView.reloadData()
    }
    
    private func didSetfilteredPokemonListData(_ oldValue: [PokemonData]) {
        pokemonListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedPokemonAtIndex = pokemonListTableView.indexPathForSelectedRow?.row {
            let pokemonList: PokemonData
            
            if (searchPokemon.text ?? "").isEmpty {
                pokemonList = pokemonListData[selectedPokemonAtIndex]
            } else {
                pokemonList = filteredPokemonListData[selectedPokemonAtIndex]
            }
            
            let destinationViewController = segue.destination as? PokemonDetailViewController
            destinationViewController?.pokemonData = pokemonList
        }
    }
    
}

extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchPokemon.text ?? "").isEmpty {
            return pokemonListData.count
        } else {
            return filteredPokemonListData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as? PokemonListTableViewCell {
            let pokemonList: PokemonData
            let pokemonId: Int
            
            if searchPokemon.text?.isEmpty == true {
                pokemonList = pokemonListData[indexPath.row]
                pokemonId = indexPath.row + 1
            } else {
                pokemonList = filteredPokemonListData[indexPath.row]
                pokemonId = indexPath.row + 1
            }
            
            cell.setupPokemonListUI(pokemonList: pokemonList, pokemonId: pokemonId)
            
            return cell
        }  else {
            fatalError()
        }
        
    }
    
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemonListData.count - 1 && loadingView.isHidden {
            loadingView.isHidden = false
            pokemonRequest
                .requestPokemonList(offset: offset, limit: limit, callback: { [weak self] in
                    self?.handleResponse(result: $0) })
        }
    }
    
}

extension PokemonListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchLogic(from: searchText)
    }
}

extension PokemonListViewController {
    
    func handleSearchLogic(from searchText: String) {
        filteredPokemonListData = pokemonListData.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
    }
}
