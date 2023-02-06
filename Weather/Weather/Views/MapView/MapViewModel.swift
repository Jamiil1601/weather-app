//
//  MapViewModel.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 04/02/2023.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

final class MapViewModel: ViewModelStateProtocol, ObservableObject {
    
    @Inject private var apiManager: ApiManagerProtocol
    @Inject private var favoriteWeatherLocationStore: FavoriteWeatherLocationStoreProtocol
    
    @Published var state: ViewModelState = .none
    var favoriteLocations = [LocationOnMap]()
        
    private var cancellableSet: Set<AnyCancellable> = []
    
    func getFavoriteLocationDetails(favorites: [Weather]) {
        for weather in favorites {
            var currentLoc = ""

            if currentLoc != weather.name {
                currentLoc = weather.name ?? ""
                let loc = LocationOnMap(name: weather.name!, coordinate: weather.coordinate?.coordinate2D ?? CLLocationCoordinate2D(latitude: 0, longitude: 0))

                self.favoriteLocations.append(loc)
            }
        }
    }
}
