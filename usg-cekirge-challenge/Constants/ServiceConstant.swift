//
//  ServiceConstant.swift
//  usg-cekirge-challenge
//
//  Created by Hakan Or on 20.05.2023.
//

import Foundation

extension Constant {
    enum ServiceEndPoint: String {
        
        case BASE_URL = "https://rickandmortyapi.com/api/"
        
        static func charactersServiceEndPoint() -> String {
            "\(BASE_URL.rawValue)character/"
        }
        static func singleCharacterServiceEndPoint(charId: String) -> String {
            "\(BASE_URL.rawValue)character/\(charId)"
        }
        
        static func charactersWithResidentsServiceEndPoint(residentIds: [String]) -> String {
            "\(BASE_URL.rawValue)character/\(residentIds.joined(separator: ","))"
        }
        
        static func locationsServiceEndPoint(page:Int) -> String {
            "\(BASE_URL.rawValue)location/?page=\(page)"
        }
    }
}
