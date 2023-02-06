//
//  Location.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 03/02/2023.
//

import CoreLocation
import Foundation

struct LocationOnMap: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

