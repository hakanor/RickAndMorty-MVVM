//
//  CharacterDetailsViewModel.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 6.05.2024.
//

import Foundation
import UIKit

protocol CharacterDetailsViewModelDelegate: AnyObject {
    func didFetchCharacterImage(data: Data)
    func didFetchImageFailed(error: Error)
}

protocol CharacterDetailsViewModelInterface {
    var delegate: CharacterDetailsViewModelDelegate? { get set }
    var character: Character { get set }
    var detailsArray: [(key: String, value: String)] { get set}
    func fetchCharacterImage()
}

final class CharacterDetailsViewModel: CharacterDetailsViewModelInterface {
    
    weak var delegate: CharacterDetailsViewModelDelegate?
    
    var character: Character
    var detailsArray: [(key: String, value: String)] = []
    
    init(character: Character) {
        self.character = character
        setupArray()
    }
    
    private func setupArray(){
        detailsArray.append(("Status:", self.character.status))
        detailsArray.append(("Specy:", self.character.species))
        detailsArray.append(("Gender:", self.character.gender))
        detailsArray.append(("Origin:", self.character.origin.name))
        detailsArray.append(("Location:", self.character.location.name))
        var episodeString = ""
        let episodeNumbers = character.episode.compactMap { $0.components(separatedBy: "/").last }
        for episode in episodeNumbers {
            episodeString += episode + " "
        }
        detailsArray.append(("Episodes:", episodeString))
        
        let dateString = self.character.created
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: dateString) else { return }
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm:ss"
        let resultString = dateFormatter.string(from: date)
        detailsArray.append(("Created at:", resultString))
    }
    
    // MARK: - API
    func fetchCharacterImage() {
        let url = URL(string: self.character.image)
        let service = NetworkServiceImpl()
        service.fetchData(path: self.character.image) { data in
            self.delegate?.didFetchCharacterImage(data: data)
        } onError: { error in
            self.delegate?.didFetchImageFailed(error: error)
        }
    }
}
