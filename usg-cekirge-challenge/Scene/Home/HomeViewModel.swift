//
//  HomeViewModel.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 21.05.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFetchLocations()
    func didFetchCharacters()
    func didFetchCharactersForLocation()
    func didFetchMoreLocations()
    func onError(error: Error)
}

protocol HomeViewModelInterface {
    var delegate: HomeViewModelDelegate? { get set }
    var characters: [Character] { get }
    var locations: [Location] { get }
    
    func fetchLocations()
    func fetchCharacters()
    func fetchCharactersForLocation(location: Location)
    func fetchCharactersForLocation(at index: Int)
}

final class HomeViewModel: HomeViewModelInterface {
    // MARK: - Properties
    var locations: [Location] = []
    var characters: [Character] = []
    
    private var currentPage: Int = 1
    
    private let apiService: ApiService
    weak var delegate: HomeViewModelDelegate?
    
    init (apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchLocations() {
        if currentPage > 1 {
            fetchMoreLocations()
        } else {
            apiService.fetchLocations(page: currentPage) { locations in
                self.locations = locations
                self.delegate?.didFetchLocations()
            } onError: { error in
                self.delegate?.onError(error: error)
            }
        }
        currentPage += 1
    }
    
    func fetchCharacters() {
        apiService.fetchCharacters { characters in
            self.characters = characters
            self.delegate?.didFetchCharacters()
        } onError: { error in
            self.delegate?.onError(error: error)
        }
    }
    
    func fetchCharactersForLocation(location: Location) {
        let residents = location.residents
        apiService.fetchCharactersByResidents(residents: residents) { characters in
            self.characters = characters
            self.delegate?.didFetchCharactersForLocation()
        } onError: { error in
            self.delegate?.onError(error: error)
        }
    }
    
    private func fetchMoreLocations() {
        apiService.fetchLocations(page: currentPage) { [weak self] locations in
            guard let self = self else { return }
            self.locations.append(contentsOf: locations)
            self.delegate?.didFetchMoreLocations()
        } onError: { error in
            self.delegate?.onError(error: error)
        }
    }
    
    func fetchCharactersForLocation(at index: Int) {
        let location = locations[index]
        let residents = location.residents
        apiService.fetchCharactersByResidents(residents: residents) { [weak self] characters in
            guard let self = self else { return }
            self.characters = characters
            self.delegate?.didFetchCharactersForLocation()
        } onError: { [weak self] error in
            self?.delegate?.onError(error: error)
        }
    }
}
