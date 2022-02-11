//
//  PokemonListService.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import Foundation

struct PokemonListService: DataRequest {
    
    var queryItems: [String : String] {
        let pagination = Pagination()
        var items = [String : String]()
        items["limit"] = String(pagination.limit)
        items["offset"] = String(pagination.offset)
        
        return items
    }
    
    var url: String
    
    var api = "pokemon"
        
    var method: HTTPMethod {
        .get
    }
    
    init(url: String? = nil) {
        self.url = url ?? ""
        
        if self.url.isEmpty {
            self.url = createUrl()
        }
    }
    
    func decode(_ data: Data) throws -> PokemonList? {
        let decoder = JSONDecoder()
        let response = try decoder.decode(PokemonList.self, from: data)
        return response
    }
    
    private func createUrl() -> String {
        var urlComps = URLComponents(string: PokemonListService.baseUrl)!
        urlComps.path.append(contentsOf: api)
        queryItems.keys.forEach {
            let urlQueryItem = URLQueryItem(name: $0, value: queryItems[$0])
            urlComps.queryItems?.append(urlQueryItem)
        }
        return urlComps.url?.absoluteString ?? ""
    }
    
}

struct Pagination {
    var limit = 100
    var offset = 0
}
