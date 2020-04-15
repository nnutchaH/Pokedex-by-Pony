//
//  PokemonDetailViewController.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 11/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Kingfisher
import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var frontShinyImage: UIImageView!
    @IBOutlet weak var backShinyImage: UIImageView!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    @IBOutlet weak var dfLabel: UILabel!
    @IBOutlet weak var spLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    let refreshDetailControl = UIRefreshControl()
    let pokemonRequest = PokemonRequest()
    var pokemonData: PokemonData!
    var pokemonDetail: PokemonDetail!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonRequest.requestPokemonDetail(name: pokemonData.name, callback: { [weak self] in
        self?.handleResponse(result: $0) })
        addRefreshDetailControl()

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

    private func addRefreshDetailControl() {
        refreshDetailControl.tintColor = .darkGray
        refreshDetailControl.addTarget(self, action: #selector(refreshPokemonDetailData), for: .valueChanged)
        detailScrollView.refreshControl = refreshDetailControl
    }
    
    @objc private func refreshPokemonDetailData(_ sender: Any) {
        fetchPokemonDetailData()
    }
    
    private func fetchPokemonDetailData() {
        pokemonRequest.requestPokemonDetail(name: pokemonData.name, callback: { [weak self] in
        self?.handleResponse(result: $0) })
        self.refreshDetailControl.endRefreshing()
    }
    
    func setupPokemonListUI() {
        
        let urlFront = URL(string: pokemonDetail!.sprites.front_default)
        let urlBack = URL(string: pokemonDetail!.sprites.back_default)
        let urlFrontShiny = URL(string: pokemonDetail!.sprites.front_shiny)
        let urlBackShiny = URL(string: pokemonDetail!.sprites.back_shiny)
        
        pokemonName.text = pokemonDetail.name
        
        pokemonImage.kf.setImage(with: urlFront)
        frontImage.kf.setImage(with: urlFront)
        backImage.kf.setImage(with: urlBack)
        frontShinyImage.kf.setImage(with: urlFrontShiny)
        backShinyImage.kf.setImage(with: urlBackShiny)
        
        hpLabel.text = String(pokemonDetail.stats[0].base_stat)
        atLabel.text = String(pokemonDetail.stats[1].base_stat)
        dfLabel.text = String(pokemonDetail.stats[2].base_stat)
        spLabel.text = String(pokemonDetail.stats[5].base_stat)
        heightLabel.text = String(pokemonDetail.height)
        weightLabel.text = String(pokemonDetail.weight)
        idLabel.text = String(pokemonDetail.id)
        typeLabel.text = pokemonDetail.types[0].type.name
    }
}
