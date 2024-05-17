//
//  ApiService.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 23.04.2023.
//

import Foundation
import Alamofire

protocol ApiService {
    func fetchCharacters(onSuccess: @escaping ([Character]) -> Void, onError: @escaping (Error) -> Void)
    func fetchCharactersByResidents(residents: [String],onSuccess: @escaping ([Character]) -> Void, onError: @escaping (Error) -> Void)
    func fetchLocations(page:Int, onSuccess: @escaping ([Location]) -> Void, onError: @escaping (Error) -> Void)
}

final class ApiServiceImpl: ApiService {
    
    let networkService: Networking
    
    init(networkService: Networking = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func fetchCharacters(onSuccess: @escaping ([Character]) -> Void, onError: @escaping (Error) -> Void) {
        networkService.fetch(path: Constant.ServiceEndPoint.charactersServiceEndPoint()) { (response: Response<Character>) in
            onSuccess(response.results)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchLocations(page:Int, onSuccess: @escaping ([Location]) -> Void, onError: @escaping (Error) -> Void) {
        networkService.fetch(path: Constant.ServiceEndPoint.locationsServiceEndPoint(page: page)) { (response: Response) in
            onSuccess(response.results)
        } onError: { error in
            onError(error)
        }
    }
    
    func fetchCharactersByResidents(residents: [String], onSuccess: @escaping ([Character]) -> Void, onError: @escaping (Error) -> Void) {
        let residentIds = residents.compactMap { $0.components(separatedBy: "/").last }
        print(residentIds)
        print(Constant.ServiceEndPoint.charactersWithResidentsServiceEndPoint(residentIds: residentIds))
        networkService.fetch(path: Constant.ServiceEndPoint.charactersWithResidentsServiceEndPoint(residentIds: residentIds)) { (response: [Character]) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
