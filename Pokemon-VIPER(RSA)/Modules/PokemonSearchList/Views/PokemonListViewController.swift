//
//  ViewController.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
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

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListViewTVCell.reuseId, for: indexPath) as? PokemonListViewTVCell else {
            return UITableViewCell()
        }
        cell.label.text = "Debug Ashish"
        cell.selectionStyle = .none
        return cell
    }
    
}

