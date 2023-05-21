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

final class HomeViewModel {
    // MARK: - Properties
    var locations: [Location] = []
    var characters: [Character] = []
    var currentPage: Int = 1
    
    private let apiService: ApiService
    weak var delegate: HomeViewModelDelegate?
    
    init (apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchLocations() {
        apiService.fetchLocations(page: currentPage) { locations in
            if let locations = locations {
                self.locations = locations
                self.delegate?.didFetchLocations()
            }
        } onError: { error in
            self.delegate?.onError(error: error)
        }
    }
    
    func fetchCharacters() {
        apiService.fetchCharacters { characters in
            if let characters = characters {
                self.characters = characters
                self.delegate?.didFetchCharacters()
            }
        } onError: { error in
            self.delegate?.onError(error: error)
        }
    }
    
    func fetchCharactersForLocation(location: Location) {
        let residents = location.residents
        apiService.fetchCharactersByResidents(residents: residents) { characters in
            if let characters = characters {
                self.characters = characters
                self.delegate?.didFetchCharactersForLocation()
            }
        } onError: { error in
            self.delegate?.onError(error: error)
        }
    }
    
    func fetchMoreLocations() {
        apiService.fetchLocations(page: currentPage) { [weak self] locations in
            guard let self = self, let locations = locations else { return }
            self.locations.append(contentsOf: locations)
            self.delegate?.didFetchMoreLocations()
        } onError: { error in
            self.delegate?.onError(error: error)
        }
    }
    
    func didSelectLocation(at index: Int) {
        let location = locations[index]
        let residents = location.residents
        switch residents.count {
        case 0:
            self.characters = []
            delegate?.didFetchCharactersForLocation()
        case 1:
            let charId = residents.compactMap { $0.components(separatedBy: "/").last }.first ?? ""
            apiService.fetchSingleCharacter(charId: charId) { [weak self] character in
                guard let self = self else { return }
                self.characters = character ?? []
                self.delegate?.didFetchCharactersForLocation()
            } onError: { [weak self] error in
                self?.delegate?.onError(error: error)
            }
        default:
            apiService.fetchCharactersByResidents(residents: residents) { [weak self] characters in
                guard let self = self else { return }
                self.characters = characters ?? []
                self.delegate?.didFetchCharactersForLocation()
            } onError: { [weak self] error in
                self?.delegate?.onError(error: error)
            }
        }
    }
}
