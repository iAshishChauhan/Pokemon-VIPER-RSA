//
//  Reducible.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import Foundation

protocol State {
    
}

protocol Action {
    
}

protocol Reducible {
    associatedtype Stateable: State
    associatedtype Actionable: Action
    
    func reduce(state: Stateable, action: Actionable) -> Stateable
}
