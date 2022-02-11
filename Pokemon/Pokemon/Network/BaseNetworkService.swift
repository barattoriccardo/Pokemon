//
//  BaseRequest.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

enum HttpCodes: Int {
    case ok = 200
    case multipleChoices = 300
}

final class BaseNetworkService: NetworkService {
    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
            
        let url = URL(string: request.url)
        
        var urlRequest = URLRequest(url: url ?? URL(fileURLWithPath: ""))
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, HttpCodes.ok.rawValue..<HttpCodes.multipleChoices.rawValue ~= response.statusCode else {
                return completion(.failure(NSError()))
            }
            
            guard let data = data else {
                return completion(.failure(NSError()))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
