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
    private var sut: ApiServiceImpl!
    private var networkService: NetworkServiceMock!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        sut = ApiServiceImpl(networkService: networkService)
    }
    
    func test_apiService_fetchCharacters_shouldReturnCharacters_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Characters")
        networkService.successResult = Response<Character>(info: .init(count: 0, pages: 0, next: "", prev: ""), results: MockCharacter.characters)
        
        // When
        sut.fetchCharacters { characters in
            // Then
            XCTAssertNotNil(characters)
            XCTAssertTrue(self.networkService.fetchCalled)
            XCTAssertEqual(self.networkService.fetchCallCount, 1)
            expectation.fulfill()
        } onError: { error in
            XCTFail("Should fail")
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchCharacters_shouldReturnError_whenOnError() {
        // Given
        let expectation = XCTestExpectation(description: "Failed to Fetch Characters")
        networkService.errorResult = NSError(domain: "NSURLErrorDomain", code: 1003)
        
        // When
        sut.fetchCharacters { characters in
            // Should fail.
            XCTAssertNil(characters)
        } onError: { error in
            // Then
            XCTAssertNotNil(error)
            XCTAssertTrue(self.networkService.fetchCalled)
            XCTAssertEqual(self.networkService.fetchCallCount, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
        
    func test_apiService_fetchCharactersByResidents_shouldReturnCharacter_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Character")
        networkService.successResult = MockCharacter.characters
        let residents = [
            "https://rickandmortyapi.com/api/character/119",
            "https://rickandmortyapi.com/api/character/123",
            "https://rickandmortyapi.com/api/character/135"
        ]
        
        // When
        sut.fetchCharactersByResidents(residents: residents) { characters in
            //Then
            XCTAssertNotNil(characters)
            XCTAssertTrue(self.networkService.fetchCalled)
            XCTAssertEqual(self.networkService.fetchCallCount, 1)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchCharactersByResidents_shouldReturnError_whenOnError() {
        // Given
        let expectation = XCTestExpectation(description: "Failed to Fetch Character")
        networkService.errorResult = NSError(domain: "NSURLErrorDomain", code: 1003)
        
        // When
        sut.fetchCharactersByResidents(residents: []) { characters in
            //error
        } onError: { error in
            //Then
            XCTAssertNotNil(error)
            XCTAssertTrue(self.networkService.fetchCalled)
            XCTAssertEqual(self.networkService.fetchCallCount, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchLocations_shouldReturnCharacter_whenOnSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch Location")
        networkService.successResult = Response<Location>(info: .init(count: 0, pages: 0, next: "", prev: ""), results: MockLocation.locations)
        
        // When
        sut.fetchLocations(page: 0) { locations in
            // Then
            XCTAssertNotNil(locations)
            XCTAssertEqual(locations.count, MockLocation.locations.count)
            XCTAssertTrue(self.networkService.fetchCalled)
            XCTAssertEqual(self.networkService.fetchCallCount, 1)
            expectation.fulfill()
        } onError: { error in
            XCTAssertNil(error)
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_apiService_fetchLocations_shouldReturnError_whenOnError() {
        // Given
        let expectation = XCTestExpectation(description: "Failed to Fetch Locations")
        networkService.errorResult = NSError(domain: "NSURLErrorDomain", code: 1003)
        
        // When
        sut.fetchLocations(page: 0) { locations in
            
        } onError: { error in
            // Then
            XCTAssertNotNil(error)
            XCTAssertTrue(self.networkService.fetchCalled)
            XCTAssertEqual(self.networkService.fetchCallCount, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
