//
//  PokemonDetailViewController.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 11/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    @IBOutlet weak var spLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    
    let pokemonRequest = PokemonRequest()
    var pokemonData: PokemonData!
    var pokemonDetail: PokemonDetail!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonRequest.requestPokemonDetail(name: pokemonData.name, callback: { [weak self] in
        self?.handleResponse(result: $0) })

    }
    
    private func handleResponse(result: Result<PokemonDetail, Error>) {
        switch result {
        case .success(let data):
            pokemonDetail = data.self
            self.setupPokemonListUI()
            
        case .failure(let error):
            print("error: \(error)")
        }
    }

    func setupPokemonListUI() {
        pokemonName.text = pokemonDetail.name
    }
}
