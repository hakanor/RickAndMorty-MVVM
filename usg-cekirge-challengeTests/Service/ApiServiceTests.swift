//
//  ApiServiceTests.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 22.05.2023.
//

import XCTest
import Alamofire
@testable import usg_cekirge_challenge

final class ApiServiceImplTests: XCTestCase {
    private var sut: ApiServiceMock!

    override func setUp() {
        super.setUp()
        sut = ApiServiceMock()
        // init networkService
    }
    
    func test_apiService_fetchCharacters_shouldReturnCharacters_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Characters")
        let charactersMock = MockCharacter.characters
        sut.isSuccess = true
        
        // When
        sut.fetchCharacters { characters in
            //Then
            XCTAssertNotNil(characters)
            XCTAssertEqual(characters.count, charactersMock.count)
            XCTAssertTrue(characters.contains { $0.id == charactersMock[0].id })
            XCTAssertTrue(characters.contains { $0.id == charactersMock[1].id })
            XCTAssertTrue(self.sut.fetchCharactersCalled)
            XCTAssertEqual(self.sut.fetchCharactersCallsCount, 1)
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
            XCTAssertTrue(self.sut.fetchCharactersCalled)
            XCTAssertEqual(self.sut.fetchCharactersCallsCount, 1)
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
            XCTAssertNotNil(character)
            XCTAssertTrue(self.sut.fetchSingleCharacterCalled)
            XCTAssertEqual(self.sut.fetchSingleCharacterCallsCount, 1)
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
            XCTAssertTrue(self.sut.fetchSingleCharacterCalled)
            XCTAssertEqual(self.sut.fetchSingleCharacterCallsCount, 1)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchCharactersByResidents_shouldReturnCharacter_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Character")
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
            XCTAssertTrue(self.sut.fetchCharactersByResidentsCalled)
            XCTAssertEqual(self.sut.fetchCharactersByResidentsCallsCount, 1)
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
            XCTAssertTrue(self.sut.fetchCharactersByResidentsCalled)
            XCTAssertEqual(self.sut.fetchCharactersByResidentsCallsCount, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchLocations_shouldReturnCharacter_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Location")
        sut.isSuccess = true
        let locationsMock = MockLocation.locations
        
        // When
        sut.fetchLocations(page: 0) { locations in
            //Then
            XCTAssertNotNil(locations)
            XCTAssertEqual(locations.count, 2)
            XCTAssertEqual(locations.count, locationsMock.count)
            XCTAssertEqual(locations.first?.id, locationsMock.first?.id)
            XCTAssertTrue(self.sut.fetchLocationsCalled)
            XCTAssertEqual(self.sut.fetchLocationsCallsCount, 1)
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
        
        // When
        sut.fetchLocations(page: 0) { locations in
            
        } onError: { error in
            // Then
            XCTAssertNotNil(error)
            expectation.fulfill()
            XCTAssertTrue(self.sut.fetchLocationsCalled)
            XCTAssertEqual(self.sut.fetchLocationsCallsCount, 1)
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

