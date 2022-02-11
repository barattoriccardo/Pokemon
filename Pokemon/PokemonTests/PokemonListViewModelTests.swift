//
//  PokemonListViewModelTests.swift
//  PokemonTests
//
//  Created by Riccardo Baratto on 11/02/22.
//

import XCTest
@testable import Pokemon

class PokemonListViewModelTests: XCTestCase {

    var viewModel: PokemonListViewModel?
    
    override func setUp() {
        super.setUp()
        viewModel = PokemonListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func testGetDetails() {
        
        let pokemonDetail = PokemonDetail(base_experience: 100,
                                          forms: nil,
                                          height: 80,
                                          id: 0,
                                          moves: nil,
                                          name: "Charizard",
                                          species: nil,
                                          sprites: nil,
                                          stats: nil,
                                          types: nil,
                                          weight: 150)
        
        viewModel?.addPokemon(pokemonDetail: pokemonDetail)
        
        let detail = viewModel?.getDetails(index: 0)
        
        XCTAssertNotNil(detail)
        XCTAssertEqual(detail?.id, 0)
        XCTAssertEqual(detail?.name, "Charizard")
    }
    
    func testMustRefresh() {
        
        for index in 1...10 {
            
            let pokemonDetail = PokemonDetail(base_experience: 100,
                                              forms: nil,
                                              height: 80,
                                              id: index,
                                              moves: nil,
                                              name: "Charizard",
                                              species: nil,
                                              sprites: nil,
                                              stats: nil,
                                              types: nil,
                                              weight: 150)
            
            viewModel?.addPokemon(pokemonDetail: pokemonDetail)
        }
        
        let refresh = viewModel?.mustRefreshPage(with: 10)
        
        XCTAssertEqual(refresh, false)
    }

}
