//
//  NetworkServiceTest.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 6.05.2024.
//

import XCTest
@testable import usg_cekirge_challenge

class NetworkServiceTests: XCTestCase {
    
    var networkService: Networking!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceImpl()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testFetch_DecodableResponse_Success() {
        // Given
        let url = "https://api.example.com/data"
        let expectation = XCTestExpectation(description: "Fetch data successfully")
        
        // When
        networkService.fetch(path: url, onSuccess: { (response: Character) in
            // Then
            XCTAssertNotNil(response)
            expectation.fulfill()
        }) { error in
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_RawData_Success() {
        // Given
        let url = "https://api.example.com/rawdata"
        let expectation = XCTestExpectation(description: "Fetch raw data successfully")
        
        
        // When
        networkService.fetchData(path: url, onSuccess: { data in
            // Then
            XCTAssertNotNil(data)
            
            expectation.fulfill()
        }) { error in
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetch_DecodableResponse_Failure() {
        // Given
        let url = "https://api.example.com/invalidpath"
        let expectation = XCTestExpectation(description: "Fetch should fail")
        
        // When
        networkService.fetch(path: url, onSuccess: { (response: Response<Character>) in
            XCTFail("Unexpected success: should fail")
        }) { error in
            // Then
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_RawData_Failure() {
        // Given
        let url = "https://api.example.com/invalidpath"
        let expectation = XCTestExpectation(description: "Fetch should fail")
        
        
        // When
        networkService.fetchData(path: url, onSuccess: { data in
            XCTFail("Unexpected success: should fail")
        }) { error in
            // Then
            
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 5.0)
    }
}
