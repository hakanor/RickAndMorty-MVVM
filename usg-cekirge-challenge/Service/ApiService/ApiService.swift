//
//  ApiService.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 23.04.2023.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    func fetchCharacters(onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchLocations(page:Int, onSuccess: @escaping ([Location]?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchCharactersByResidents(residents: [String],onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void)
}

final class ApiService: ServiceProtocol {
    
    private init() {}
    
    static let shared = ApiService()
    
    func fetchCharacters(onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.ServiceEndPoint.charactersServiceEndPoint()) { (response: [Character]?) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    
    func fetchLocations(page:Int, onSuccess: @escaping ([Location]?) -> Void, onError: @escaping (Alamofire.AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.ServiceEndPoint.locationsServiceEndPoint(page: page)) { (response: [Location]?) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchCharactersByResidents(residents: [String], onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void) {
        let residentIds = residents.compactMap { $0.components(separatedBy: "/").last }
        print(Constant.ServiceEndPoint.charactersWithResidentsServiceEndPoint(residentIds: residentIds))
        ServiceManager.shared.fetch(path: Constant.ServiceEndPoint.charactersWithResidentsServiceEndPoint(residentIds: residentIds)) { (response: [Character]?) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchCharactersByResidents2(residents: [String], completion: @escaping ([Character]?) -> Void) {
        let residentIds = residents.compactMap { $0.components(separatedBy: "/").last }
        // documentation/#get-multiple-characters
        let url = "\(baseUrl)character/\(residentIds.joined(separator: ","))"
        print(url)
        AF.request(url).responseDecodable(of: [Character].self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print("Error fetchCharactersByResidents: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchCharacters2(completion: @escaping ([Character]?) -> Void) {
        let url = "\(baseUrl)character/"
        AF.request(url).responseDecodable(of: Response<Character>.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                print("Error fetchCharacters: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
