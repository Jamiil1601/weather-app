//
//  DailyWeather.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 25/01/2023.
//

import Foundation
import SwiftUI

struct DailyWeather: Equatable {
    let date: Date
    let weatherConditionIcon: Image?
    let temperature: Double
}

func ==(lhs: DailyWeather, rhs: DailyWeather) -> Bool {
    return lhs.date == rhs.date
    && lhs.weatherConditionIcon == rhs.weatherConditionIcon
    && lhs.temperature == rhs.temperature
}
