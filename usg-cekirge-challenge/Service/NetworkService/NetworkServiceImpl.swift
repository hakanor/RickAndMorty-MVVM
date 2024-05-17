//
//  ServiceManager.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 20.05.2023.
//

import Alamofire
import Foundation

protocol Networking {
    func fetch<T: Codable>(path: String, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ())
    func fetchData(path: String, onSuccess: @escaping (Data) -> (), onError: @escaping (Error) -> ())
}

//MARK: - NetworkServiceImpl
final class NetworkServiceImpl {
    init() {
        
    }
}

extension NetworkServiceImpl: Networking {
    func fetch <T> (path: String, onSuccess: @escaping (T) -> (), onError: @escaping (Error) -> ()) where T: Codable {
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                print("Error (ServiceManager): \(error.localizedDescription)")
                onError(error)
            }
        }
    }
    
    func fetchData(path: String, onSuccess: @escaping (Data) -> (), onError: @escaping (Error) -> ()) {
        AF.request(path).responseData { response in
            switch response.result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                print("Error (ServiceManager): \(error.localizedDescription)")
                onError(error)
            }
        }
    }
}
