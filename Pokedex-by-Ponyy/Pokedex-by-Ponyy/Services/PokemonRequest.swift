//
//  PokemonRequest.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 10/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//

import Foundation
import Moya

class PokemonRequest {
    
    let provider = MoyaProvider<PokemonAPI>()
    
    func requestPokemonList(offset: Int, limit: Int, callback: ((Result<PokemonList, Error>) -> Void)?) {
        provider
            .request(
            .pokemonList(offset: offset, limit: limit)) { result in
                switch result {
                case .success(let response):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    do {
                        let data = try jsonDecoder.decode(PokemonList.self, from: response.data)
                        callback?(.success(data))
                    } catch {
                        callback?(.failure(error))
                    }
                case .failure(let error):
                    callback?(.failure(error))
                }
        }
    }
        
        func requestPokemonDetail(name: String, callback: ((Result<PokemonDetail, Error>) -> Void)?) {
            provider
                .request(
                .getPokemonDetail(name: name)) { result in
                    switch result {
                    case .success(let response):
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .iso8601
                        do {
                            let data = try jsonDecoder.decode(PokemonDetail.self, from: response.data)
                            callback?(.success(data))
                        } catch {
                            callback?(.failure(error))
                        }
                    case .failure(let error):
                        callback?(.failure(error))
                    }
            }
        }
        
}
