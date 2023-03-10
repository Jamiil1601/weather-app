//
//  PlaceDetails.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 01/02/2023.
//

import Foundation
import CoreLocation

struct PlaceDetails: Decodable {
    let result: PlaceResult
}

struct PlaceResult: Decodable {
    let geometry: Geometry
}

struct Geometry: Decodable {
    let location: Location
}

struct Location: Decodable {
    let longitude: Double
    let latitude: Double
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lng"
        case latitude = "lat"
    }
}

extension Location {
    var coordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
