//
//  WeatherForecastViewModel.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 25/01/2023.
//

import Foundation
import CoreLocation
import Combine

final class WeatherForecastViewModel: ViewModelStateProtocol, ObservableObject {
    @Inject private var apiManager: ApiManagerProtocol
        
    @Published var weatherForecasts: [DailyWeather]?
    @Published var state: ViewModelState = .none

    private var cancellableSet: Set<AnyCancellable> = []
    
    func fetchWeatherForecast(coordinate: CLLocationCoordinate2D) {
        state = .isLoading
        
        apiManager.fetchWeatherForecast(coordinate: coordinate)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    
                    self?.weatherForecasts = self?.extractFirstForecastDaily(data: dataResponse.value)
                } else {
                    //TODO: Create item for error
                    self?.state = .error
                    print("Error \(dataResponse.error)")
                }
            }.store(in: &cancellableSet)
    }
    
    func extractFirstForecastDaily(data: WeatherForecast?) -> [DailyWeather] {
        var currentDay = ""
        var forecasts = [DailyWeather]()
        
        /*
         * Note that the forecast5 api returns forecasts on a 3hr basis.
         * Here I am taking the first forecast for each day
         * It also returns forecast for 6 days and for that we could pick only the last 5 days' forecasts
         */
        for weather in data?.list ?? [] {
            if currentDay != weather.date.weekDay {
                currentDay = weather.date.weekDay
                
                forecasts.append(
                    DailyWeather(
                        date: weather.date,
                        weatherConditionIcon: weather.weatherConditions.first?.weatherIcon,
                        temperature: weather.temperature.currentTemp
                    )
                )
            }
        }
        
        return forecasts
    }
}
