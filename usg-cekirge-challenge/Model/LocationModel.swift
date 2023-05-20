//
//  LocationModel.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 20.05.2023.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
