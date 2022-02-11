//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import Foundation

protocol PokemonListDelegate: AnyObject {
    func didGetAllPokemonDetails()
}

class PokemonListViewModel {
    var delegate: PokemonListDelegate?
    
    var pokemonList: PokemonList?
    private var pokemonsDetailsArray = [PokemonDetail]()
    private let networkService = BaseNetworkService()
    private (set) var count = 0
    
    final func fetchPokemonList() {
        let request = PokemonListService(url: pokemonList?.next)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let list):
                self?.count = (self?.count ?? 0) + (list?.results?.count ?? 0)
                self?.pokemonList = list
                self?.getPokemonDetails(pokemonArray: list?.results)
            case .failure(let error):
                debugPrint("error \(error)")
            }
        }
    }
    
    final func getDetails(index: Int) -> PokemonDetail {
        return pokemonsDetailsArray[index]
    }
    
    final func getPokemonDetails(pokemonArray: [Pokemon]?) {
        guard let pokeArray = pokemonArray else { return }
        
        for pokemon in pokeArray {
            let request = PokemonDetailService(pokemon: pokemon)
            
            networkService.request(request) { [weak self] result in
                switch result {
                case .success(let pokemonDet):
                    self?.addPokemon(pokemonDetail: pokemonDet)
                case .failure(let error):
                    debugPrint("error \(error)")
                }
            }
        }
    }
    
    final func addPokemon(pokemonDetail: PokemonDetail?) {
        guard let det = pokemonDetail else { return }
        
        pokemonsDetailsArray.append(det)
        pokemonsDetailsArray = pokemonsDetailsArray.sorted(by: { $0.id! < $1.id! })
        
        if pokemonsDetailsArray.count == count {
            delegate?.didGetAllPokemonDetails()
        }
    }
    
    final func mustRefreshPage(with index: Int) -> Bool {
        return index == count - 10 && pokemonList?.count ?? 0 > count
    }
}
