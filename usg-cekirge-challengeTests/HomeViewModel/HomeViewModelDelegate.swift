//
//  HomeViewModelDelegate.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 8.05.2024.
//

import Foundation
@testable import usg_cekirge_challenge

final class HomeViewModelDelegateMock: HomeViewModelDelegate {
    
    var didFetchLocationsCallsCount = 0
    var didFetchLocationsCalled: Bool {
        didFetchLocationsCallsCount > 0
    }

    func didFetchLocations() {
        didFetchLocationsCallsCount += 1
    }

    var didFetchCharactersCallsCount = 0
    var didFetchCharactersCalled: Bool {
        didFetchCharactersCallsCount > 0
    }

    func didFetchCharacters() {
        didFetchCharactersCallsCount += 1
    }

    var didFetchCharactersForLocationCallsCount = 0
    var didFetchCharactersForLocationCalled: Bool {
        didFetchCharactersForLocationCallsCount > 0
    }

    func didFetchCharactersForLocation() {
        didFetchCharactersForLocationCallsCount += 1
    }

    var didFetchMoreLocationsCallsCount = 0
    var didFetchMoreLocationsCalled: Bool {
        didFetchMoreLocationsCallsCount > 0
    }

    func didFetchMoreLocations() {
        didFetchMoreLocationsCallsCount += 1
    }

    var onErrorCallsCount = 0
    var onErrorCalled: Bool {
        onErrorCallsCount > 0
    }

    func onError(error: Error) {
        onErrorCallsCount += 1
    }
}
