//
//  CharacterModel.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 20.05.2023.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    struct Location: Codable {
        let name: String
        let url: String
    }
    
    struct Origin: Codable {
        let name: String
        let url: String
    }
}

struct Response<T: Codable>: Codable {
    let info: Info
    let results: [T]
}
