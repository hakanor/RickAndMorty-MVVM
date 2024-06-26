//
//  Mockable.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 8.05.2024.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON <T : Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON <T : Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            print("❌ \(error)")
            fatalError("Failed to decode the JSON.")
        }
    }
    
    func loadData(filename: String) -> Data {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON file.")
        }
        
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            print("❌ \(error)")
            fatalError("Failed to load the data.")
        }
    }
    
}
