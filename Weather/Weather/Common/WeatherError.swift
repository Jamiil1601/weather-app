//
//  WeatherError.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 02/02/2023.
//

import SwiftUI

enum WeatherError: Error {
    case noDataError
    case locationPermissionDenied
}

extension WeatherError {
    var alertItem: AlertItem {
        switch self {
        case .noDataError:
            return AlertItem(
                desc: Text(NSLocalizedString("NO_DATA_FOUND", comment: "")),
                primaryBtn: .default(Text(NSLocalizedString("OK", comment: ""))))
        case .locationPermissionDenied:
            return AlertItem(
                desc: Text(NSLocalizedString("LOCATION_PERMISSION_DENIED", comment: "")),
                primaryBtn: .default(Text(NSLocalizedString("OK", comment: "")), action: {
                    if let url = URL(string:UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }))
        }
    }
}
