//
//  HomeViewController.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 23.04.2023.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    var locations: [Location] = []
    var characters: [Character] = []
    var currentPage: Int = 1
    
    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = "Title"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 100)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectioncell")
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureCollectionView()
        fetchLocations()
        fetchCharacters()
    }
    
    // MARK: - Helper Functions
    private func configureUI(){
        view.backgroundColor = .yellow
        [titleLabel, collectionView, tableView] .forEach(view.addSubview(_:))
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 0, paddingRight: 0)
        
        collectionView.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 14, paddingLeft: 0, paddingRight: 0, height: 120)
                
        tableView.anchor(top: collectionView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right:view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 10, paddingRight: 0)
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0  )
    }
    
    private func configureCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectioncell")
    }
    
    // MARK: - API
    private func fetchLocations(){
        ApiService.shared.fetchLocations(page: currentPage) { locations in
            if let locations = locations {
                self.locations = locations
                self.collectionView.reloadData()
            } else {
                print("Failed to fetch locations.")
            }
        }
    }
    
    private func fetchCharacters(){
        ApiService.shared.fetchCharacters { characters in
            if let characters = characters {
                self.characters = characters
                self.tableView.reloadData()
            } else {
                print("Failed to fetch characters.")
            }
        }
    }
    
    func fetchCharactersForLocation(location: Location) {
        let residents = location.residents
        ApiService.shared.fetchCharactersByResidents(residents: residents) { [weak self] characters in
            guard let self = self, let characters = characters else { return }
            self.characters = characters
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - TableView DataSource and Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailsViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true,completion: nil)
    }
}

// MARK: - CollectionView DataSource and Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRowIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            currentPage += 1
            ApiService.shared.fetchLocations(page: currentPage) { [weak self] locations in
                guard let self = self, let locations = locations else { return }
                self.locations.append(contentsOf: locations)
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath)
        let label = UILabel(frame: cell.bounds)
        label.text = locations[indexPath.row].name
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let residents = location.residents
        ApiService.shared.fetchCharactersByResidents(residents: residents) { characters in
            self.characters = characters ?? []
            self.tableView.reloadData()
        }
    }
}
