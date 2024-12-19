//
//  ViewController.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    func fetchPokemonList() {
        guard let url = URL(string: PokemonAPIEndpoint.getPokemonList) else { return }
        NetworkHandler.shared.fetchData(with: url) { (result: Result<PokemonAPIDataModel?, NetworkError>) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }


}

