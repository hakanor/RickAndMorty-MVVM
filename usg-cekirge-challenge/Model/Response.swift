//
//  Response.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 6.05.2024.
//

struct Response<T: Codable>: Codable {
    
    init(info: Response<T>.Info, results: [T]) {
        self.info = info
        self.results = results
    }
    
    let info: Info
    let results: [T]
    
    struct Info: Codable {
        let count: Int?
        let pages: Int?
        let next: String?
        let prev: String?
    }
}
