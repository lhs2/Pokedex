//
//  PokeListView.swift
//  Pokedex
//
//  Created by Luiz Henrique on 27/05/2024.
//

import UIKit
import Alamofire
import AlamofireImage

final class PokeListView: UIView {
    var currentPokemonList: [(title:String, url: String)] = [("Test", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif"), ("Test2", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"), ("Test3", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"), ("Test4", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"), ("Test5", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png"), ("Test6", "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .white
        searchBar.sizeToFit()
        searchBar.placeholder = "Search by Pokemon name"
        return searchBar
    }()
    
    let tableView: UITableView = {
        return UITableView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTableView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.register(PokeListTableViewCell.self, forCellReuseIdentifier: PokeListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}

extension PokeListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeListTableViewCell.identifier) as? PokeListTableViewCell else {
            return UITableViewCell()
        }
        var content = cell.defaultContentConfiguration()
        let pokemon = currentPokemonList[indexPath.row]
        content.text = "No 000 - UNKNOWN"
        content.image = UIImage(imageLiteralResourceName: "pokeball_placeholder")
        content.imageProperties.maximumSize = CGSize(width: 80, height: 80)
        AF.request(pokemon.url).responseImage { response in
            let size = CGSize(width: 80, height: 80)
            if case .success(let image) = response.result {
                let scaledImage = image.af.imageScaled(to: size)
                cell.pokemonName = pokemon.title
                cell.loadedImage = scaledImage
            }
            
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPokemonList.count
    }
}
