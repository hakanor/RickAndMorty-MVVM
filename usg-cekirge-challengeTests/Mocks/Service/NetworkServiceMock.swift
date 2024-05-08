//
//  NetworkServiceMock.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 6.05.2024.
//

import Foundation
@testable import usg_cekirge_challenge

class NetworkServiceMock: Networking {
    
    var fetchCallCount = 0
    var fetchCalled: Bool {
        fetchCallCount > 0
    }
    
    var successResult: Codable?
    var errorResult: Error?
    
    // received arg. doğru path kıyasla
    
    func fetch<T>(path: String, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) where T : Codable {
        fetchCallCount += 1
        if let successResult {
            onSuccess(successResult as! T)
        } else if let errorResult {
            onError(errorResult)
        }
    }
    
    func fetchData(path: String, onSuccess: @escaping (Data) -> (), onError: @escaping (Error) -> ()) {
        
    }
    
}
