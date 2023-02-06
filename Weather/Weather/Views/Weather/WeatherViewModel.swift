//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 22/01/2023.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI

final class WeatherViewModel: ViewModelStateProtocol, ObservableObject {
    @Inject private var apiManager: ApiManagerProtocol
    @Inject private var favoriteWeatherLocationStore: FavoriteWeatherLocationStoreProtocol
        
    @Published var state: ViewModelState = .none
    @Published var currentWeather: Weather?
    @Published var weatherColor = WeatherConditionType.sunny.themeColor
    @Published var weatherImage: Image?
    @Published var temperature: Temperature?
    @Published var cityName: String?
        
    private var cancellableSet: Set<AnyCancellable> = []
    
    func fetchCurrentWeather(coordinate: CLLocationCoordinate2D) {
        state = .isLoading
        
        apiManager.fetchCurrentWeather(coordinate: coordinate)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    self?.currentWeather = dataResponse.value
                    
                    if let weather = dataResponse.value,
                       let color = weather.weatherConditions.first?.conditionType.themeColor {
                        
                        self?.weatherColor = color
                        self?.weatherImage = weather.weatherConditions.first?.image
                        self?.temperature = weather.temperature
                        self?.cityName = weather.name
                    }
                } else {
                    //TODO: Create item for error
                    self?.state = .error
                }
            }.store(in: &cancellableSet)
    }
    
    func toggleFavorite() {
        guard let safeCurrentWeather = currentWeather else { return }
        
        favoriteWeatherLocationStore.exists(weather: safeCurrentWeather) { [weak self] result in
            guard let strongSelf = self else { return }

            switch result {
            case .success(let index):
                strongSelf.favoriteWeatherLocationStore.remove(atIndex: index) { _ in
                    self?.currentWeather?.isFavorited = false
                }
            case .failure(let error):
                if error == .noDataError {
                    strongSelf.favoriteWeatherLocationStore.save(weather: safeCurrentWeather) { _ in
                        self?.currentWeather?.isFavorited = true
                    }
                }
            }
        }
    }
}
