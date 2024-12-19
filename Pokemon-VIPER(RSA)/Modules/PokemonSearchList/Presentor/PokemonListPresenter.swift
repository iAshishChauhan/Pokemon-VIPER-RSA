//
//  PokemonListPresenter.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

final class PokemonListPresenter {
    var interactor: PokemonListInteractor?
    var router: PokemonListRouter?
    var state: PokemonState?
    weak var view: PokemonListPresenterCallback?
    
    init(interactor: PokemonListInteractor?, router: PokemonListRouter?) {
        self.interactor = interactor
        self.router = router
    }
    
    func handlePageLoad() {
        interactor?.handle(action: .initiatePokemonListRequest)
    }
    
    private func getViewModel(state: PokemonState) -> PokemonListViewModel {
        return PokemonListViewModel(pokemonData: state.pokemonsList)
    }
    
}

extension PokemonListPresenter: PokemonListInteractorCallback {
    func didStateChanged(state: PokemonState) {
        self.state = state
        view?.didUpdateUI(viewModel: getViewModel(state: state))
    }
    
}
