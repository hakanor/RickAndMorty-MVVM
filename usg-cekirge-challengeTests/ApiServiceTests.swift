//
//  ApiServiceTests.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 22.05.2023.
//

import XCTest
import Alamofire
@testable import usg_cekirge_challenge

final class ApiServiceTests: XCTestCase {
    private var sut: MockApiService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MockApiService()
    }
    
    func test_apiService_fetchCharacters_shouldReturnCharacters_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Characters")
        let charactersMock = MockCharacter.createMockCharacters()
        sut.isSuccess = true
        
        // When
        sut.fetchCharacters { characters in
            //Then
            XCTAssertNotNil(characters)
            XCTAssertEqual(characters?.count, charactersMock.count)
            XCTAssertTrue(characters?.contains { $0.id == charactersMock[0].id } ?? false)
            XCTAssertTrue(characters?.contains { $0.id == charactersMock[1].id } ?? false)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchCharacters_shouldReturnError_whenOnError() {
        // Given
        let expectation = XCTestExpectation(description: "Failed to Fetch Characters")
        sut.isSuccess = false
        
        // When
        sut.fetchCharacters { characters in
            // Should fail.
        } onError: { error in
            //Then
            XCTAssertNotNil(error)
            XCTAssertEqual(error.localizedDescription, AFError.explicitlyCancelled.localizedDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchSingleCharacter_shouldReturnCharacter_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Character")
        var charactersMock: [Character] = []
        let character = MockCharacter.createMockCharacter()
        charactersMock.append(character)
        sut.isSuccess = true
        
        // When
        sut.fetchSingleCharacter(charId: "\(character.id)") { characters in
            //Then
            XCTAssertNotNil(characters)
            XCTAssertEqual(characters?.count, charactersMock.count)
            XCTAssertTrue(characters?.contains { $0.id == charactersMock[0].id } ?? false)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchSingleCharacter_shouldReturnError_whenOnError() {
        // Given
        let expectation = XCTestExpectation(description: "Failed to Fetch Character")
        sut.isSuccess = false
        
        // When
        sut.fetchSingleCharacter(charId: "") { characters in
            // Should fail.
        } onError: { error in
            //Then
            XCTAssertNotNil(error)
            XCTAssertEqual(error.localizedDescription, AFError.explicitlyCancelled.localizedDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchCharactersByResidents_shouldReturnCharacter_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Character")
        var charactersMock = MockCharacter.createMockCharacters()
        // How to test residents ??
        // prob. residents -> residentIds shouldnt be here.
        let residents = [
            "https://rickandmortyapi.com/api/character/119",
            "https://rickandmortyapi.com/api/character/123",
            "https://rickandmortyapi.com/api/character/135"
        ]
        sut.isSuccess = true
        
        // When
        sut.fetchCharactersByResidents(residents: residents) { characters in
            //Then
            XCTAssertNotNil(characters)
            XCTAssertEqual(characters?.count, charactersMock.count)
            XCTAssertTrue(characters?.contains { $0.id == charactersMock[0].id } ?? false)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchCharactersByResidents_shouldReturnError_whenOnError() {
        // Given
        let expectation = XCTestExpectation(description: "Failed to Fetch Character")
        sut.isSuccess = false
        
        // When
        sut.fetchCharactersByResidents(residents: []) { characters in
            //error
        } onError: { error in
            //Then
            XCTAssertNotNil(error)
            XCTAssertEqual(error.localizedDescription, AFError.explicitlyCancelled.localizedDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchLocations_shouldReturnCharacter_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Location")
        var locationsMock = MockLocation.createMockLocations()
        sut.isSuccess = true
        
        sut.fetchLocations(page: 0) { locations in
            //Then
            XCTAssertNotNil(locations)
            XCTAssertEqual(locations?.count, 20)
            XCTAssertEqual(locations?.count, locationsMock.count)
            XCTAssertEqual(locations?.first?.id, locationsMock.first?.id)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchLocations_shouldReturnError_whenOnError() {
        // Given
        let expectation = XCTestExpectation(description: "Failed to Fetch Locations")
        sut.isSuccess = false
        
        sut.fetchLocations(page: 0) { locations in
            //
        } onError: { error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error.localizedDescription, AFError.explicitlyCancelled.localizedDescription)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

final class MockApiService: ServiceProtocol {
    var isSuccess: Bool = true
    func fetchCharacters(onSuccess: @escaping ([usg_cekirge_challenge.Character]?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        if isSuccess {
            onSuccess(MockCharacter.createMockCharacters())
        } else {
            onError(AFError.explicitlyCancelled)
        }
    }
    
    func fetchCharactersByResidents(residents: [String], onSuccess: @escaping ([usg_cekirge_challenge.Character]?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        if isSuccess {
            onSuccess(MockCharacter.createMockCharacters())
        } else {
            onError(AFError.explicitlyCancelled)
        }
    }
    
    func fetchSingleCharacter(charId: String, onSuccess: @escaping ([usg_cekirge_challenge.Character]?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        if isSuccess {
            onSuccess([MockCharacter.createMockCharacter()])
        } else {
            onError(AFError.explicitlyCancelled)
        }
    }
    
    func fetchLocations(page: Int, onSuccess: @escaping ([usg_cekirge_challenge.Location]?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        if isSuccess {
            onSuccess(MockLocation.createMockLocations())
        } else {
            onError(AFError.explicitlyCancelled)
        }
    }
}

struct MockCharacter {
    static func createMockCharacter() -> Character {
        let location = Character.Location(name: "Earth", url: "https://example.com/earth")
        let origin = Character.Location(name: "Unknown", url: "https://example.com/unknown")
        let character = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "Genius",
            gender: "Male",
            origin: origin,
            location: location,
            image: "https://example.com/image.png",
            episode: ["https://example.com/episode/1", "https://example.com/episode/2"],
            url: "https://example.com/character/1",
            created: "2023-05-20T12:34:56.789Z"
        )
        return character
    }
    
    static func createMockCharacters() -> [Character] {
        let character = MockCharacter.createMockCharacter()
        var characters : [Character] = []
        characters.append(character)
        characters.append(character)
        return characters
    }
}

struct MockLocation {
    static func createMockLocation() -> Location {
        let location = Location(
            id: 1,
            name: "Earth",
            type: "Planet",
            dimension: "Dimension C-137",
            residents: ["https://example.com/resident/1", "https://example.com/resident/2"],
            url: "https://example.com/location/1",
            created: "2023-05-20T12:34:56.789Z"
        )
        return location
    }
    
    static func createMockLocations() -> [Location] {
        let location = MockLocation.createMockLocation()
        var locations: [Location] = []
        for _ in 1...20 {
            locations.append(location)
        }
        return locations
    }
}

