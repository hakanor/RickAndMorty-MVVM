//
//  ServiceManager.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 20.05.2023.
//

import Alamofire

//MARK: - ServiceManager
final class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    func fetch <T> (path: String, onSuccess: @escaping ([T]?) -> (), onError: @escaping (AFError) -> ()) where T: Codable {
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of: Response<T>.self) { response in
            switch response.result {
            case .success(let value):
                onSuccess(value.results)
            case .failure(let error):
                print("Error (ServiceManager): \(error.localizedDescription)")
                onError(error)
            }
        }
    }
}
