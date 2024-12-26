//
//  PocemonListProtocols.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

protocol PokemonListInteractorCallback: AnyObject {
    func didStateChanged(state: PokemonState)
}

protocol PokemonListPresenterCallback: AnyObject {
    func didUpdateUI(datasource: PokemonState)
}
