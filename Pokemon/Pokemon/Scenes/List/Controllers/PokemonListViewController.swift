//
//  ViewController.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let viewModel = PokemonListViewModel()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPage()
    }
    
    private func initPage() {
        createTableView()
        
        title = "Pokemon"
        viewModel.delegate = self
        viewModel.fetchPokemonList()
    }
    
    private func createTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        tableView.register(PokemonListCell.self, forCellReuseIdentifier: PokemonListCell.name)
    }
}

extension PokemonListViewController: PokemonListDelegate {
    
    func didGetAllPokemonDetails() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListCell.name) as? PokemonListCell {
            cell.viewModel = PokemonDetailsViewModel(pokemon: viewModel.getDetails(index: indexPath.row))
            
            if viewModel.mustRefreshPage(with: indexPath.row) {
                viewModel.fetchPokemonList()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PokemonDetailsViewController()
        vc.setup(with: viewModel.getDetails(index: indexPath.row))
        navigationController?.pushViewController(vc, animated: true)
    }
}
