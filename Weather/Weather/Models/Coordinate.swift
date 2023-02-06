//
//  Coordinate.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 26/01/2023.
//

import Foundation
import CoreLocation

struct Coordinate: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

extension Coordinate {
    var coordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
    lhs.latitude == rhs.latitude
    && lhs.longitude == rhs.longitude
}
