//
//  PokemonListCell.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import UIKit

class PokemonListCell: UITableViewCell {
    static let name = String(describing: PokemonListCell.self)
    
    private var imgPokemon: UIImageView!
    private var lblPokemon: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    var viewModel: PokemonDetailsViewModel? {
        didSet {
            populateCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgPokemon.image = nil
    }

    func createCell() {
        
        self.selectionStyle = .none
        
        imgPokemon = UIImageView()
        self.addSubview(imgPokemon)
        
        lblPokemon = UILabel()
        self.addSubview(lblPokemon)
        
        imgPokemon.translatesAutoresizingMaskIntoConstraints = false
        imgPokemon.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        imgPokemon.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        imgPokemon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imgPokemon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        lblPokemon.translatesAutoresizingMaskIntoConstraints = false
        lblPokemon.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        lblPokemon.leadingAnchor.constraint(equalTo: imgPokemon.trailingAnchor, constant: 10).isActive = true
        lblPokemon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        lblPokemon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    func populateCell() {
        imgPokemon.image(from: viewModel?.getImageUrl() ?? "", placeHolder: UIImage(named: "placeholder")!)
        lblPokemon.text = viewModel?.getName()
    }
}
