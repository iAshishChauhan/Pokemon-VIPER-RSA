//
//  PokemonListViewDefines.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

enum PokemonListFlowState {
    case none
    case initiatedListFetch
    case successfullListFetch
    case initiatedPaginationListFetch
    case successfullPaginationListFetch
    case failedListFetch
    case initiateNavigationToDetailPage
}

enum PokemonListAction {
    case initiatePokemonListRequest
    case pokemonListFetched(PokemonAPIDataModel)
    case initiatePokemonPaginationFetch
    case pokemonListPaginationDataFetched(PokemonAPIDataModel)
    case pokemonTapped(PokemonData)
}

final class PokemonState {
    var pokemonsList: PokemonAPIDataModel = PokemonAPIDataModel(count: nil,
                                                                next: nil,
                                                                results: nil)
    var flowstate: PokemonListFlowState = .none
}
