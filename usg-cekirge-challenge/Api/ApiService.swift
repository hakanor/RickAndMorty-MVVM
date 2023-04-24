//
//  ApiService.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 23.04.2023.
//

import Foundation
import Alamofire

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: CharacterLocation
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterLocation: Codable {
    let name: String
    let url: String
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Response<T: Codable>: Codable {
    let info: Info
    let results: [T]
}

class ApiService {
    static let shared = ApiService()
    
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    private init() {}
    
    func fetchLocations(page: Int, completion: @escaping ([Location]?) -> Void) {
        let url = "\(baseUrl)location/?page=\(page)"
        AF.request(url).responseDecodable(of: Response<Location>.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                print("Error fetchLocations: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
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
    
    func fetchCharactersByResidents(residents: [String], completion: @escaping ([Character]?) -> Void) {
        let residentIds = residents.compactMap { $0.components(separatedBy: "/").last }
        // documentation/#get-multiple-characters
        let url = "\(baseUrl)character/\(residentIds.joined(separator: ","))"
//        print(url)
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
}
