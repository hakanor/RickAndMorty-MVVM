//
//  ApiServiceMock.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 6.05.2024.
//

import Foundation
@testable import usg_cekirge_challenge

final class ApiServiceMock: ApiService {
    
    var networkService = NetworkServiceMock()
    
    var isSuccess = true
    
    var fetchCharactersCallsCount = 0
    var fetchCharactersCalled: Bool {
        fetchCharactersCallsCount > 0
    }
    
    func fetchCharacters(onSuccess: @escaping ([usg_cekirge_challenge.Character]) -> Void, onError: @escaping (Error) -> Void) {
        fetchCharactersCallsCount += 1
        if isSuccess {
            onSuccess(MockCharacter.characters)
        } else {
            let error = NSError(domain: "Error", code: 404)
            onError(error)
        }
    }
    
    var fetchCharactersByResidentsCallsCount = 0
    var fetchCharactersByResidentsCalled: Bool {
        fetchCharactersByResidentsCallsCount > 0
    }
    
    func fetchCharactersByResidents(residents: [String], onSuccess: @escaping ([usg_cekirge_challenge.Character]) -> Void, onError: @escaping (Error) -> Void) {
        fetchCharactersByResidentsCallsCount += 1
        if isSuccess {
            onSuccess(MockCharacter.characters)
        } else {
            let error = NSError(domain: "Error", code: 404)
            onError(error)
        }
    }
    
    var fetchSingleCharacterCallsCount = 0
    var fetchSingleCharacterCalled: Bool {
        fetchSingleCharacterCallsCount > 0
    }
    
    func fetchSingleCharacter(charId: String, onSuccess: @escaping (usg_cekirge_challenge.Character) -> Void, onError: @escaping (Error) -> Void) {
        fetchSingleCharacterCallsCount += 1
        if isSuccess {
            onSuccess(MockCharacter.character)
        } else {
            let error = NSError(domain: "Error", code: 404)
            onError(error)
        }
    }
    
    var fetchLocationsCallsCount = 0
    var fetchLocationsCalled: Bool {
        fetchLocationsCallsCount > 0
    }
    
    func fetchLocations(page: Int, onSuccess: @escaping ([usg_cekirge_challenge.Location]) -> Void, onError: @escaping (Error) -> Void) {
        fetchLocationsCallsCount += 1
        if isSuccess {
            onSuccess(MockLocation.locations)
        } else {
            let error = NSError(domain: "Error", code: 404)
            onError(error)
        }
    }
}
