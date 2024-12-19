//
//  PokemonListPresenter.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

class PokemonListPresenter {
    var interactor: PokemonListInteractor?
    var router: PokemonListRouter?
    
    init(interactor: PokemonListInteractor?, router: PokemonListRouter?) {
        self.interactor = interactor
        self.router = router
    }
}
