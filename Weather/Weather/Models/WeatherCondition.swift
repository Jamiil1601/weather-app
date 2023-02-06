//
//  WeatherCondition.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 26/01/2023.
//

import Foundation
import SwiftUI

enum WeatherConditionType {
    case rainy
    case sunny
    case cloudy
    
    var themeColor: String {
        switch self {
        case .rainy:
            return "rainy"
        case .sunny:
            return "sunny"
        case .cloudy:
            return "cloudy"
        }
    }
}

struct WeatherCondition: Codable, Equatable {
    let id: Int
    let weatherCondTitle: String
    let weatherCondDesc: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case weatherCondTitle = "main"
        case weatherCondDesc = "description"
    }
}

extension WeatherCondition {
    
    var conditionType: WeatherConditionType {
        switch id {
            //Based on Open Weather Map Api Weather condition codes. See docs.
        case 200...781:
            //Considering all conditions as rainy (thunder, snow, etc...) except sunny and cloudy
            return .rainy
        case 800:
            return .sunny
        default:
            return .cloudy
        }
    }
    
    var image: Image {
        switch conditionType {
        case .rainy:
            return Image("seaRainy")
        case .sunny:
            return Image("seaSunny")
        default:
            return Image("seaCloudy")
        }
    }
    
    var weatherIcon: Image {
        switch conditionType {
        case .rainy:
            return Image("rainyIcon")
        case .sunny:
            return Image("sunnyIcon")
        default:
            return Image("cloudyIcon")
        }
    }
    
    var label: String {
        var localizedStringKey: String
        
        switch conditionType {
        case .rainy:
            localizedStringKey = "RAINY"
        case .sunny:
            localizedStringKey = "SUNNY"
        default:
            localizedStringKey = "CLOUDY"
        }
        
        return NSLocalizedString(localizedStringKey, comment: "")
    }
}

func ==(lhs: WeatherCondition, rhs: WeatherCondition) -> Bool {
    return lhs.id == rhs.id
}
