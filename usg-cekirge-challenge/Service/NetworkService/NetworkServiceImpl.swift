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
}

//MARK: - ServiceManager
final class NetworkServiceImpl {
    static let shared: NetworkServiceImpl = NetworkServiceImpl()
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
    
    func fetchSingleObject<T: Codable>(path: String, onSuccess: @escaping (T?) -> (), onError: @escaping (AFError) -> ()) {
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
    
    func fetchArrayResponse <T> (path: String, onSuccess: @escaping (T?) -> (), onError: @escaping (AFError) -> ()) where T: Codable {
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
}
