//
//  PokemonDetailService.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import Foundation

struct PokemonDetailService: DataRequest {
        
    var api = "pokemon"
    
    var url: String
    
    var method: HTTPMethod {
        .get
    }
    
    init(pokemon: Pokemon) {
        var url = URL(string: PokemonListService.baseUrl)
        url?.appendPathComponent(api)
        url?.appendPathComponent(pokemon.name ?? "")
        self.url = url?.absoluteString ?? ""
    }
    
    func decode(_ data: Data) throws -> PokemonDetail? {
        let decoder = JSONDecoder()
        let response = try decoder.decode(PokemonDetail.self, from: data)
        return response
    }
    
}

