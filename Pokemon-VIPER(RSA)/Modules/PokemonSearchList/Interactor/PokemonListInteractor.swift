//
//  PokemonListInteractor.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

final class PokemonListInteractor {
    
    var reducer: PokemonListReducer
    var networkHandler: NetworkHandler
    var state: PokemonState
    weak var presenter: PokemonListInteractorCallback?
    
    init(reducer: PokemonListReducer, networkHandler: NetworkHandler, state: PokemonState) {
        self.reducer = reducer
        self.networkHandler = networkHandler
        self.state = state
    }
    
    func handle(action: PokemonListAction) {
        let state = reducer.handle(action: action, state: state)
        self.state = state
        presenter?.didStateChanged(state: state)
        handleState(state: state)
    }
    
    private func handleState(state: PokemonState) {
        switch state.flowstate {
        case .initiateListFetch:
            fetchPokemonList()
        default:
            break
        }
    }
    
    func fetchPokemonList() {
        guard let url = URL(string: PokemonAPIEndpoint.getPokemonList) else { return }
        networkHandler.fetchData(with: url) { (result: Result<PokemonAPIDataModel?, NetworkError>) in
            switch result {
            case .success(let data):
                if let data {
                    DispatchQueue.main.async {
                        self.handle(action: .pokemonListFetched(data))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
