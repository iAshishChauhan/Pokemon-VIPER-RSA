//
//  PokemonListViewDefines.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

final class PokemonListViewModel {
    let listOfPokemons: [PokemonData]
    
    init(listOfPokemons: [PokemonData]) {
        self.listOfPokemons = listOfPokemons
    }
}
