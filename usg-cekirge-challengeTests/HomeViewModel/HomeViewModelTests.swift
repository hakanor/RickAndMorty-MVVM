//
//  HomeViewModelTests.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 8.05.2024.
//

import XCTest
@testable import usg_cekirge_challenge

/// func fetchLocations() +
/// func fetchCharacters() +
/// func fetchCharactersForLocation(location: Location)
/// func fetchCharactersForLocation(at index: Int)
final class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!
    private var networkService: MockNetworking!
    private var apiService: ApiServiceImpl!
    private var homeViewModelDelegate: HomeViewModelDelegateMock!

    override func setUp() {
        super.setUp()
        networkService = MockNetworking()
        apiService = ApiServiceImpl(networkService: networkService)
        sut = HomeViewModel(apiService: apiService)
        homeViewModelDelegate = HomeViewModelDelegateMock()
        sut.delegate = homeViewModelDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        homeViewModelDelegate = nil
        apiService = nil
        networkService = nil
    }
    
    func test_fetchLocations_ShouldSuccess() {
        // Given
        networkService.mockType = .success("LocationResponse")
        
        // When
        sut.fetchLocations()
        
        // Then
        XCTAssertNotEqual(sut.locations.count, 0)
        XCTAssertTrue(homeViewModelDelegate.didFetchLocationsCalled)
    }
    
    func test_fetchLocations_ShouldFail() {
        // Given
        networkService.mockType = .failure
        
        // When
        sut.fetchLocations()
        
        // Then
        XCTAssertEqual(sut.locations.count, 0)
        XCTAssertFalse(homeViewModelDelegate.didFetchLocationsCalled)
        XCTAssertTrue(homeViewModelDelegate.onErrorCalled)
    }
    
    func test_fetchCharacters_ShouldSuccess() {
        // Given
        networkService.mockType = .success("CharacterResponse")
        
        // When
        sut.fetchCharacters()
        
        // Then
        XCTAssertNotEqual(sut.characters.count, 0)
        XCTAssertTrue(homeViewModelDelegate.didFetchCharactersCalled)
    }
    
    func test_fetchCharacters_ShouldFail() {
        // Given
        networkService.mockType = .failure
        
        // When
        sut.fetchCharacters()
        
        // Then
        XCTAssertEqual(sut.characters.count, 0)
        XCTAssertFalse(homeViewModelDelegate.didFetchCharactersCalled)
        XCTAssertTrue(homeViewModelDelegate.onErrorCalled)
    }
}
