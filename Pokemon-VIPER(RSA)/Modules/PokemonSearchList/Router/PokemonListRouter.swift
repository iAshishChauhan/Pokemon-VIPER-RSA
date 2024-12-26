//
//  PokemonListRouter.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import UIKit

final class PokemonListRouter {
    
    var view: ViewControllable
    
    init(view: ViewControllable) {
        self.view = view
    }
    
    static func createPokemonListModule(viewRef: PokemonListViewController) {
        let router = PokemonListRouter(view: viewRef)
        let interacter = PokemonListInteractor(reducer: PokemonListReducer(),
                                               networkHandler: NetworkHandler.shared,
                                               state: PokemonState())
        let presenter = PokemonListPresenter(interactor: interacter, router: router)
        
        viewRef.presentor = presenter
        presenter.view = viewRef
        interacter.presenter = presenter
        
    }
}
