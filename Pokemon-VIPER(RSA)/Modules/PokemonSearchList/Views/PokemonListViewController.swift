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
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var footerSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var isLoadingMore: Bool = false
    private var datasource: PokemonState?
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
        tableView.tableFooterView = footerSpinner
    }
    
}

extension PokemonListViewController: PokemonListPresenterCallback {
    func didUpdateUI(datasource: PokemonState) {
        self.datasource = datasource
        switch datasource.flowstate {
        case .successfullListFetch:
            tableView.reloadData()
        case .successfullPaginationListFetch:
            isLoadingMore = false
            footerSpinner.stopAnimating()
            tableView.reloadData()
        default:
            break
        }
    }
    
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.pokemonsList.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListViewTVCell.reuseId, for: indexPath) as? PokemonListViewTVCell,
              let item = datasource?.pokemonsList.results?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.nameLabel.text = item.name?.capitalized
        cell.linkLabel.text = item.url
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = datasource?.pokemonsList.results?[indexPath.row] else { return }
        presentor?.handleRedirectionToDetail(data: pokemon)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfSections = tableView.numberOfSections
        let numberOfRowsInLastSection = tableView.numberOfRows(inSection: numberOfSections - 1)
        
        guard !isLoadingMore,
              indexPath.section == numberOfSections - 1,
              indexPath.row == numberOfRowsInLastSection - 1 else { return }
        
        footerSpinner.startAnimating()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            self.presentor?.handleLoadMore()
        }
    }
    
}

