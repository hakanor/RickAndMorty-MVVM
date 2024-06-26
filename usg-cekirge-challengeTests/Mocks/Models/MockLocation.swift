//
//  MockLocation.swift
//  usg-cekirge-challengeTests
//
//  Created by Hakan Or on 6.05.2024.
//

import Foundation
@testable import usg_cekirge_challenge

struct MockLocation {
    
    static let locations: [Location] = {
        return [createMockLocation(), createMockLocation()]
    }()
    
    static let location: Location = {
        return createMockLocation()
    }()
    
    static func createMockLocation() -> Location {
        let location = Location(
            id: 1,
            name: "Earth",
            type: "Planet",
            dimension: "Dimension C-137",
            residents: ["https://example.com/resident/1", "https://example.com/resident/2"],
            url: "https://example.com/location/1",
            created: "2023-05-20T12:34:56.789Z"
        )
        return location
    }
}

extension MockLocation {
    static let jsonData: Data = {
        let jsonString = """
        {
            "info": {
                "count": 126,
                "pages": 7,
                "next": null,
                "prev": "https://rickandmortyapi.com/api/location?page=6"
            },
            "results": [
                {
                    "id": 121,
                    "name": "Rick's Consciousness",
                    "type": "Consciousness",
                    "dimension": "Replacement Dimension",
                    "residents": [],
                    "url": "https://rickandmortyapi.com/api/location/121",
                    "created": "2021-10-25T09:12:23.715Z"
                },
                {
                    "id": 122,
                    "name": "Avian Planet",
                    "type": "Planet",
                    "dimension": "Replacement Dimension",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/792",
                        "https://rickandmortyapi.com/api/character/793"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/122",
                    "created": "2021-10-26T12:19:52.957Z"
                },
                {
                    "id": 123,
                    "name": "Normal Size Bug Dimension",
                    "type": "Dimension",
                    "dimension": "",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/795",
                        "https://rickandmortyapi.com/api/character/796"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/123",
                    "created": "2021-11-02T13:03:21.307Z"
                },
                {
                    "id": 124,
                    "name": "Slartivart",
                    "type": "Planet",
                    "dimension": "Replacement Dimension",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/797"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/124",
                    "created": "2021-11-02T13:07:27.619Z"
                },
                {
                    "id": 125,
                    "name": "Rick and Two Crows Planet",
                    "type": "Planet",
                    "dimension": "Replacement Dimension",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/809",
                        "https://rickandmortyapi.com/api/character/808",
                        "https://rickandmortyapi.com/api/character/787"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/125",
                    "created": "2021-11-02T13:50:55.588Z"
                },
                {
                    "id": 126,
                    "name": "Rick's Memories",
                    "type": "Memory",
                    "dimension": "",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/815",
                        "https://rickandmortyapi.com/api/character/814",
                        "https://rickandmortyapi.com/api/character/807",
                        "https://rickandmortyapi.com/api/character/94",
                        "https://rickandmortyapi.com/api/character/779",
                        "https://rickandmortyapi.com/api/character/816",
                        "https://rickandmortyapi.com/api/character/817",
                        "https://rickandmortyapi.com/api/character/274",
                        "https://rickandmortyapi.com/api/character/389",
                        "https://rickandmortyapi.com/api/character/215",
                        "https://rickandmortyapi.com/api/character/294"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/126",
                    "created": "2021-11-02T15:18:57.987Z"
                }
            ]
        }
        """
        return jsonString.data(using: .utf8)!
    }()
}
