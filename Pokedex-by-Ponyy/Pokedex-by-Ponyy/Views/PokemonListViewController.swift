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
    
    let refreshListControl = UIRefreshControl()
    let pokemonRequest = PokemonRequest()
    let pokemonListViewModel = PokemonListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonList()
        addRefreshListControl()
    }
    
    private func getPokemonList()  {
        loadingView.startAnimating()
        pokemonListViewModel.getPokemonListData()
        closureSetUp()
    }
    
    private func closureSetUp()  {
        pokemonListViewModel.reloadList = { [weak self] ()  in
            self?.pokemonListTableView.reloadData()
            self?.loadingView.isHidden = true
        }
        pokemonListViewModel.errorMessage = { [weak self] (message)  in
            print(message)
            self?.loadingView.stopAnimating()
        }
    }
    
    private func addRefreshListControl() {
        refreshListControl.tintColor = .darkGray
        refreshListControl.addTarget(self, action: #selector(refreshPokemonListData(_:)), for: .valueChanged)
        pokemonListTableView.refreshControl = refreshListControl
    }
    
    @objc private func refreshPokemonListData(_ sender: Any) {
        pokemonListViewModel.fetchPokemonListData()
        self.refreshListControl.endRefreshing()
        self.pokemonListTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedPokemonAtIndex = pokemonListTableView.indexPathForSelectedRow?.row {
            
            let pokemonList: PokemonData
            
            if (searchPokemon.text ?? "").isEmpty {
                pokemonList = pokemonListViewModel.pokemonData[selectedPokemonAtIndex]
            } else {
                pokemonList = pokemonListViewModel.filterPokemonData[selectedPokemonAtIndex]
            }
            let destinationViewController = segue.destination as? PokemonDetailViewController
            destinationViewController?.pokemonDetailViewModel.pokemonData = pokemonList
        }
    }
    
}

extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchPokemon.text ?? "").isEmpty {
            return pokemonListViewModel.pokemonData.count
        } else {
            return pokemonListViewModel.filterPokemonData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as? PokemonListTableViewCell {
            let pokemonList: PokemonData
            if searchPokemon.text?.isEmpty == true {
                pokemonList = pokemonListViewModel.pokemonData[indexPath.row]
            } else {
                pokemonList = pokemonListViewModel.filterPokemonData[indexPath.row]
            }
            cell.setupPokemonListUI(pokemonList: pokemonList)
            return cell
        }  else {
            fatalError()
        }
    }
    
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemonListViewModel.pokemonData.count - 1 && loadingView.isHidden {
            loadingView.isHidden = false
            pokemonListViewModel.getPokemonListData()
        }
    }
    
}

extension PokemonListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchPokemon: UISearchBar, textDidChange searchText: String) {
        pokemonListViewModel.searchBar(from: searchText)
        pokemonListTableView.reloadData()
    }
    
}

