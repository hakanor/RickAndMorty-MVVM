//
//  MockCharacterData.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 6.05.2024.
//

import Foundation
@testable import usg_cekirge_challenge

struct MockCharacter {
    
    static let character: Character = {
        return createMockCharacter()
    }()
    
    static let characters: [Character] = {
        return [createMockCharacter(), createMockCharacter()]
    }()
    
    static func createMockCharacter() -> Character {
        let location = Character.Location(name: "Earth", url: "https://example.com/earth")
        let origin = Character.Location(name: "Unknown", url: "https://example.com/unknown")
        let character = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "Genius",
            gender: "Male",
            origin: origin,
            location: location,
            image: "https://example.com/image.png",
            episode: ["https://example.com/episode/1", "https://example.com/episode/2"],
            url: "https://example.com/character/1",
            created: "2023-05-20T12:34:56.789Z"
        )
        return character
    }
}

extension MockCharacter {
    static let jsonData: Data = {
        let jsonString = """
                {
                    "id": 1,
                    "name": "Rick Sanchez",
                    "status": "Alive",
                    "species": "Human",
                    "type": "",
                    "gender": "Male",
                    "origin": {
                        "name": "Earth (C-137)",
                        "url": "https://rickandmortyapi.com/api/location/1"
                    },
                    "location": {
                        "name": "Earth (Replacement Dimension)",
                        "url": "https://rickandmortyapi.com/api/location/20"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/1",
                        "https://rickandmortyapi.com/api/episode/2",
                        "https://rickandmortyapi.com/api/episode/3"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/1",
                    "created": "2017-11-04T18:48:46.250Z"
                }
                """
        return jsonString.data(using: .utf8)!
    }()
}
