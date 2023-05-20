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
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo.png")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 50)
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
        view.backgroundColor = .white
        [logo, collectionView, tableView] .forEach(view.addSubview(_:))
        
        logo.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, width: UIScreen.main.bounds.width, height: 80)
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.anchor(top: logo.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: 0, height: 50)
                
        tableView.anchor(top: collectionView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right:view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
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
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "collectioncell")
    }
    
    // MARK: - API
    private func fetchLocations(){
        ApiService.shared.fetchLocations(page: currentPage) { locations in
            if let locations = locations {
                self.locations = locations
                self.collectionView.reloadData()
            }
        } onError: { error in
            print("Failed to fetch locations.")
        }
    }
    
    private func fetchCharacters(){
        ApiService.shared.fetchCharacters { characters in
            if let characters = characters {
                self.characters = characters
                self.tableView.reloadData()
            }
        } onError: { error in
            print("Failed to fetch characters")
        }
    }
    
    func fetchCharactersForLocation(location: Location) {
        let residents = location.residents
        ApiService.shared.fetchCharactersByResidents(residents: residents) { [weak self] characters in
            guard let self = self, let characters = characters else { return }
            self.characters = characters
            self.tableView.reloadData()
        } onError: { error in
            print("Failed to fetch characters by residents")
        }
    }
    
}

// MARK: - TableView DataSource and Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.configureCell(character: characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CharacterDetailsViewController(character: characters[indexPath.row])
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
            } onError: { error in
                print("Failed to fetch locations.")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! HomeCollectionViewCell
        cell.setCollectionViewCellLabel(location: self.locations[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let residents = location.residents
        ApiService.shared.fetchCharactersByResidents(residents: residents) { characters in
            self.characters = characters ?? []
            self.tableView.reloadData()
        } onError: { error in
            print("Failed to fetch characters by residents")
        }
    }
}
