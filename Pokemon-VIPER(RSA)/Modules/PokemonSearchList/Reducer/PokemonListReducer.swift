//
//  PokemonListReducer.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

final class PokemonListReducer {
    
    func handle(action: PokemonListAction, state: PokemonState) -> PokemonState {
        switch action {
        case .initiatePokemonListRequest:
            state.flowstate = .initiateListFetch
        case let .pokemonListFetched(data):
            state.flowstate = .successfullListFetch
            state.pokemonsList = data
        case let .pokemonTapped(pokemonData):
            state.flowstate = .initiateNavigationToDetailPage
            print("pokemonTapped \(pokemonData)")
        }
        return state
    }
    
}
