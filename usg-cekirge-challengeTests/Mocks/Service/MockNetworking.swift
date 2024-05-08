//
//  MockNetworking.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 8.05.2024.
//

import Foundation
@testable import usg_cekirge_challenge

class MockNetworking: Networking, Mockable {
    
    enum MockType {
        case success(String)
        case failure
    }
    
    var mockType: MockType = .success("LocationResponse")
    
    func fetch<T:Codable>(path: String, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) {
        switch mockType {
        case .success(let filename):
            let json = loadJSON(filename: filename, type: T.self)
            onSuccess(json)
        case .failure:
            let error = NSError(domain: "MockNetworking", code: 404, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
            onError(error)
        }
    }
    
    func fetchData(path: String, onSuccess: @escaping (Data) -> (), onError: @escaping (Error) -> ()) {
        switch mockType {
        case .success(let filename):
            let data = loadData(filename: filename)
            onSuccess(data)
        case .failure:
            let error = NSError(domain: "MockNetworking", code: 404, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
            onError(error)
        }
    }
}
