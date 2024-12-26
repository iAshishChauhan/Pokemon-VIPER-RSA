//
//  ViewController.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import UIKit

final class PokemonListViewController: UIViewController, ViewControllable {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    var datasource: PokemonState?
    var presentor: PokemonListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
        PokemonListRouter.createPokemonListModule(viewRef: self)
        presentor?.handlePageLoad()
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        tableView.register(PokemonListViewTVCell.self, forCellReuseIdentifier: PokemonListViewTVCell.reuseId)
    }
    
}

extension PokemonListViewController: PokemonListPresenterCallback {
    func didUpdateUI(datasource: PokemonState) {
        self.datasource = datasource
        if datasource.pokemonsList.results?.isEmpty == false {
            self.tableView.reloadData()
        }
    }
    
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.pokemonsList.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListViewTVCell.reuseId, for: indexPath) as? PokemonListViewTVCell else {
            return UITableViewCell()
        }
        cell.label.text = datasource?.pokemonsList.results?[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = datasource?.pokemonsList.results?[indexPath.row] else { return }
        presentor?.handleRedirectionToDetail(data: pokemon)
    }
    
}

