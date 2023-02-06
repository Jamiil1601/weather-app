//
//  Weather.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 26/01/2023.
//

import Foundation
import SwiftUI

struct Weather: Codable, Equatable {
    var name: String?
    var date: Date
    var coordinate: Coordinate?
    var temperature: Temperature
    var weatherConditions: [WeatherCondition]
    
    var isFavorited = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case date = "dt"
        case coordinate = "coord"
        case temperature = "main"
        case weatherConditions = "weather"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decodeIfPresent(String.self, forKey: .name)
        
        let unixTimestamp = try container.decode(Double.self, forKey: .date)
        date = Date(timeIntervalSince1970: unixTimestamp)
        
        coordinate = try container.decodeIfPresent(Coordinate.self, forKey: .coordinate)
        temperature = try container.decode(Temperature.self, forKey: .temperature)
        weatherConditions = try container.decode([WeatherCondition].self, forKey: .weatherConditions)
    }
}

func ==(lhs: Weather, rhs: Weather) -> Bool {
    return lhs.name == rhs.name
}
