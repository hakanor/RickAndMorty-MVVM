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
    func fetchCharactersByResidents(residents: [String],onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchSingleCharacter(charId: String, onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void)
    func fetchLocations(page:Int, onSuccess: @escaping ([Location]?) -> Void, onError: @escaping (AFError) -> Void)
}

final class ApiService: ServiceProtocol {
    
    private init() {}
    
    static let shared = ApiService()
    
    func fetchCharacters(onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.ServiceEndPoint.charactersServiceEndPoint()) { (response: [Character]?) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchSingleCharacter(charId: String, onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetchSingleObject(path: Constant.ServiceEndPoint.singleCharacterServiceEndPoint(charId: charId)) { (response: Character?) in
            onSuccess(response != nil ? [response!] : nil)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchLocations(page:Int, onSuccess: @escaping ([Location]?) -> Void, onError: @escaping (AFError) -> Void) {
        ServiceManager.shared.fetch(path: Constant.ServiceEndPoint.locationsServiceEndPoint(page: page)) { (response: [Location]?) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchCharactersByResidents(residents: [String], onSuccess: @escaping ([Character]?) -> Void, onError: @escaping (AFError) -> Void) {
        let residentIds = residents.compactMap { $0.components(separatedBy: "/").last }
        ServiceManager.shared.fetchArrayResponse(path: Constant.ServiceEndPoint.charactersWithResidentsServiceEndPoint(residentIds: residentIds)) { (response: [Character]?) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
