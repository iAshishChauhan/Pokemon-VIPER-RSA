//
//  PokemonAPIDataModel.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

struct PokemonAPIDataModel: Decodable {
    let count: Int?
    let next: String?
    let results: [PokemonData]?
}

struct PokemonData: Decodable {
    let name: String?
    let url: String?
}
