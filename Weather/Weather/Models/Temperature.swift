//
//  Temperature.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 26/01/2023.
//

import Foundation

struct Temperature: Codable, Equatable {
    let currentTemp: Double
    let minTemp: Double?
    let maxTemp: Double?
    
    enum CodingKeys: String, CodingKey {
        case currentTemp = "temp"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}

func ==(lhs: Temperature, rhs: Temperature) -> Bool {
    return lhs.currentTemp == rhs.currentTemp
    && lhs.minTemp == rhs.minTemp
    && lhs.maxTemp == rhs.maxTemp
}
