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
        case .initiatedListFetch:
            fetchPokemonList()
        case .initiatedPaginationListFetch:
            fetchPokemonList(paginated: true)
        default:
            break
        }
    }
    
    private func fetchPokemonList(paginated: Bool = false) {
        guard var url = URL(string: PokemonAPIEndpoint.pokemonListURL) else { return }
        if paginated, let updatedUrl = updateOffset(in: url, incrementBy: 20) {
            PokemonAPIEndpoint.pokemonListURL = updatedUrl.absoluteString
            url = updatedUrl
        }
        print("Proceeding to make API call now")
        networkHandler.fetchData(with: url) { (result: Result<PokemonAPIDataModel?, NetworkError>) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                DispatchQueue.main.async {
                    if !paginated {
                        self.handle(action: .pokemonListFetched(data))
                    } else {
                        self.handle(action: .pokemonListPaginationDataFetched(data))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateOffset(in url: URL, incrementBy value: Int) -> URL? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              var queryItems = urlComponents.queryItems else { return nil }
        
        if let index = queryItems.firstIndex(where: { $0.name == "offset" }),
           let currentOffset = Int(queryItems[index].value ?? "0") {
            // Update the offset value
            queryItems[index].value = "\(currentOffset + value)"
        } else {
            // Add "offset" if it doesn't exist
            queryItems.append(URLQueryItem(name: "offset", value: "\(value)"))
        }
        
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

}
