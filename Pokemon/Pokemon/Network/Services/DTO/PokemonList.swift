//
//  PokemonList.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import Foundation

struct PokemonList: Codable {
    
    let count : Int?
    let next : String?
    let previous : String?
    let results : [Pokemon]?
}
