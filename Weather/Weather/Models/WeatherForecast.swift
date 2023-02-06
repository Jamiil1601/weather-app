//
//  WeatherForecast.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 26/01/2023.
//

import Foundation

struct WeatherForecast: Codable {
    let list: [Weather]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case list, city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        list = try container.decode([Weather].self, forKey: .list)
        city = try container.decode(City.self, forKey: .city)
    }
}
