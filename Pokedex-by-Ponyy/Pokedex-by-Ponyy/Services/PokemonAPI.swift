//
//  PokemonAPI.swift
//  Pokedex-by-Ponyy
//
//  Created by Pony💛 yyy on 10/4/2563 BE.
//  Copyright © 2563 nnutcha. All rights reserved.
//
//https://pokeapi.co/api/v2/pokemon/?limit=30&offset=0

import Foundation
import Moya

enum PokemonAPI {
    case pokemonList(offset: Int, limit: Int)
    case getPokemonName(name: String)
}

extension PokemonAPI: TargetType {
    
   var baseURL: URL {
        return URL(string:  "https://pokeapi.co/api")!
    }
    
    var path: String {
        switch self {
        case .pokemonList:
            return "/v2/pokemon/"
        case .getPokemonName(let name):
            return "/v2/pokemon/\(name)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let.pokemonList(offset, limit):
            return .requestParameters(parameters: ["offset": offset, "limit": limit], encoding: URLEncoding.queryString)
        case .getPokemonName:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

