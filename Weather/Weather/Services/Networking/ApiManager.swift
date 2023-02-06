//
//  RequestsManager.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 25/01/2023.
//

import Foundation
import Alamofire
import Combine
import CoreLocation

protocol ApiManagerProtocol {
    func fetchCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<Weather, AFError>, Never>
    func fetchWeatherForecast(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<WeatherForecast, AFError>, Never>
    func fetchPlaceDetails(placeId: String) -> AnyPublisher<DataResponse<PlaceDetails, AFError>, Never>
    func fetchPlaceAutocomplete(query: String) -> AnyPublisher<DataResponse<PlaceAutocomplete, AFError>, Never>
}

class ApiManager: ApiManagerProtocol {
    let sessionManager: Session = {
        
        var eventMonitors = [EventMonitor]()
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        
        #if DEBUG
        let networkLogger = NetworkLogger()
        eventMonitors.append(networkLogger)
        #endif
        
        return Session(configuration: config, eventMonitors: eventMonitors)
//        let config = URLSessionConfiguration.af.default
//        config.requestCachePolicy = .returnCacheDataElseLoad
//        
//        return Session(configuration: config)
    }()
    
    func fetchCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<Weather, Alamofire.AFError>, Never> {
        return sessionManager
            .request(ApiRouter.currentWeather(coordinate: coordinate))
            .validate()
            .publishDecodable(type: Weather.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchWeatherForecast(coordinate: CLLocationCoordinate2D) -> AnyPublisher<DataResponse<WeatherForecast, Alamofire.AFError>, Never> {
        return sessionManager
            .request(ApiRouter.weatherForecast(coordinate: coordinate))
            .validate()
            .publishDecodable(type: WeatherForecast.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchPlaceDetails(placeId: String) -> AnyPublisher<DataResponse<PlaceDetails, AFError>, Never> {
        return sessionManager
            .request(ApiRouter.placeDetails(placeId: placeId))
            .validate()
            .publishDecodable(type: PlaceDetails.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchPlaceAutocomplete(query: String) -> AnyPublisher<DataResponse<PlaceAutocomplete, AFError>, Never> {
        return sessionManager
            .request(ApiRouter.placeAutocomplete(query: query))
            .validate()
            .publishDecodable(type: PlaceAutocomplete.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
