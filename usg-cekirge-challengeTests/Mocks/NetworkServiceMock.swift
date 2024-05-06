//
//  NetworkServiceMock.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 6.05.2024.
//

import Foundation
@testable import usg_cekirge_challenge

class NetworkServiceMock: Networking {
    
    var shouldSucceed = true
    var mockData = Data()
    
    var fetchCallsCount = 0
    var fetchCalled: Bool {
        fetchCallsCount > 0
    }
    
    func fetch<T>(path: String, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) where T : Decodable {
        fetchCallsCount += 1
        if shouldSucceed {
            let mockData = mockData
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: mockData)
                onSuccess(decodedData)
            } catch {
                let error = NSError(domain: "Error", code: 404)
                onError(error)
            }
        } else {
            let error = NSError(domain: "Error", code: 404)
            onError(error)
        }
    }
    
    var fetchDataCallsCount = 0
    var fetchDataCalled: Bool {
        fetchDataCallsCount > 0
    }
    
    func fetchData(path: String, onSuccess: @escaping (Data) -> (), onError: @escaping (Error) -> ()) {
        fetchDataCallsCount += 1
        if shouldSucceed {
            let mockData = Data()
            onSuccess(mockData)
        } else {
            let error = NSError(domain: "Error", code: 404)
            onError(error)
        }
    }
}
