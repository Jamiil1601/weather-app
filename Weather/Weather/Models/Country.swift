//
//  Country.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 27/01/2023.
//

import Foundation

struct Country: Codable, Equatable {
    let id: Int
    let name: String
    let sunrise: Date
    let sunset: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "country"
        case sunrise
        case sunset
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let sunriseUnixTimestamp = try container.decode(Double.self, forKey: .sunrise)
        sunrise = Date(timeIntervalSince1970: sunriseUnixTimestamp)
                
        let sunsetUnixTimestamp = try container.decode(Double.self, forKey: .sunset)
        sunset = Date(timeIntervalSince1970: sunsetUnixTimestamp)
    }
}

func ==(lhs: Country, rhs: Country) -> Bool {
    return lhs.id == rhs.id
}
