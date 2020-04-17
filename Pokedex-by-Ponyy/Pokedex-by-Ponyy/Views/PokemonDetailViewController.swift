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
    let pokemonDetailViewModel = PokemonDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonDetail()
        addRefreshDetailControl()
    }
    
    private func getPokemonDetail()  {
        pokemonDetailViewModel.getPokemonDetailData()
        closureSetUp()
    }
    
    private func closureSetUp()  {
        pokemonDetailViewModel.reloadDetail = { [weak self]()  in
            self?.setupPokemonListUI()
        }
        pokemonDetailViewModel.errorMessage = { (message)  in
            print(message)
        }
    }
    
    private func addRefreshDetailControl() {
        refreshDetailControl.tintColor = .darkGray
        refreshDetailControl.addTarget(self, action: #selector(refreshPokemonDetailData), for: .valueChanged)
        detailScrollView.refreshControl = refreshDetailControl
    }
    
    @objc private func refreshPokemonDetailData(_ sender: Any) {
        pokemonDetailViewModel.fetchPokemonListData()
        self.refreshDetailControl.endRefreshing()
    }
    
    private func setupPokemonListUI() {
        let urlFront = URL(string: pokemonDetailViewModel.pokemonDetail.sprites.front_default)
        let urlBack = URL(string: pokemonDetailViewModel.pokemonDetail.sprites.back_default)
        let urlFrontShiny = URL(string: pokemonDetailViewModel.pokemonDetail.sprites.front_shiny)
        let urlBackShiny = URL(string: pokemonDetailViewModel.pokemonDetail.sprites.back_shiny)
        
        pokemonName.text = pokemonDetailViewModel.pokemonDetail.name
        
        pokemonImage.kf.setImage(with: urlFront)
        frontImage.kf.setImage(with: urlFront)
        backImage.kf.setImage(with: urlBack)
        frontShinyImage.kf.setImage(with: urlFrontShiny)
        backShinyImage.kf.setImage(with: urlBackShiny)
        
        hpLabel.text = String(pokemonDetailViewModel.pokemonDetail.stats[0].base_stat)
        atLabel.text = String(pokemonDetailViewModel.pokemonDetail.stats[1].base_stat)
        dfLabel.text = String(pokemonDetailViewModel.pokemonDetail.stats[2].base_stat)
        spLabel.text = String(pokemonDetailViewModel.pokemonDetail.stats[5].base_stat)
        heightLabel.text = String(pokemonDetailViewModel.pokemonDetail.height)
        weightLabel.text = String(pokemonDetailViewModel.pokemonDetail.weight)
        idLabel.text = String(pokemonDetailViewModel.pokemonDetail.id)
        typeLabel.text = pokemonDetailViewModel.pokemonDetail.types[0].type.name
    }
    
}
