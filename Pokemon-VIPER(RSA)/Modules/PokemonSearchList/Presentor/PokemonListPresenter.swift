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
    
    func handleRedirectionToDetail(data: PokemonData) {
        interactor?.handle(action: .pokemonTapped(data))
    }
    
    func handleLoadMore() {
        interactor?.handle(action: .initiatePokemonPaginationFetch)
    }
    
}

extension PokemonListPresenter: PokemonListInteractorCallback {
    func didStateChanged(state: PokemonState) {
        self.state = state
        view?.didUpdateUI(datasource: state)
    }
    
}
