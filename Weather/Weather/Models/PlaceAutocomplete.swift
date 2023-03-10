//
//  PlaceAutocomplete.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 01/02/2023.
//

import Foundation

struct PlaceAutocomplete: Decodable {
    let predictions: [Place]
}

struct Place: Decodable {
    let placeId: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case description
    }
}
