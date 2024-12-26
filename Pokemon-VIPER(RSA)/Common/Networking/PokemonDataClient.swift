//
//  PokemonDataClient.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

enum PokemonAPIEndpoint {
    static var pokemonListURL = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
}

enum NetworkError: Error {
    case badData
    case badResponse
    case requestFailed
}

final class NetworkHandler {
    
    private init() {}
    
    static let shared = NetworkHandler()
    
    func fetchData<T: Decodable>(with url: URL, completionHandler: @escaping ((Result<T?, NetworkError>) -> Void)) {
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.badData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.requestFailed))
                return
            }
            
            completionHandler(.success(response))
        }
        
        dataTask.resume()
    }
    
}
