//
//  PokemonListViewTVCell.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import UIKit

final class PokemonListViewTVCell: UITableViewCell {

    static let reuseId = "PokemonListViewTVCell"
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .systemBlue
        label.font = UIFont.italicSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.addSubview(nameLabel)
        self.addSubview(linkLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            
            linkLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            linkLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            linkLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            linkLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    

}
