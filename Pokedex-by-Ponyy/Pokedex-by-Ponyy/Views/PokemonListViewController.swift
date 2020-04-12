//
//  ViewController.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 10/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var pokemonListTableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    let pokemonRequest = PokemonRequest()
    var pokemonListData: [PokemonData] = []
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PokemonDetailViewController
        vc.pokemonData = pokemonListData[pokemonListTableView.indexPathForSelectedRow!.row]
    }

}

extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonListTableViewCell", for: indexPath) as! PokemonListTableViewCell
        let pokemonList = pokemonListData[indexPath.row]
        cell.setupPokemonListUI(pokemonList: pokemonList)
        
            return cell
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
