//
//  City.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 26/01/2023.
//

import Foundation

struct City: Codable, Equatable {
    let id: Int
    let name: String
    let coordinate: Coordinate
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinate = "coord"
        case country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
        country = try container.decode(String.self, forKey: .country)
    }
}

func ==(lhs: City, rhs: City) -> Bool {
    return lhs.id == rhs.id
}
