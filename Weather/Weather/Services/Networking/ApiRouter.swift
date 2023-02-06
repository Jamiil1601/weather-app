//
//  RequestsRouter.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 25/01/2023.
//

import Foundation
import CoreLocation
import Alamofire

enum ApiRouter {
    
    //Forecast must be based on user's current location, hence parsing in CLLocationCoordinate2D (lat, long)
    case currentWeather(coordinate: CLLocationCoordinate2D)
    case weatherForecast(coordinate: CLLocationCoordinate2D)
    
    case placeDetails(placeId: String)
    case placeAutocomplete(query: String)
    
    var baseUrl: String {
        switch self {
        case .currentWeather, .weatherForecast:
            return "https://api.openweathermap.org/data/2.5"
        default:
            return "https://maps.googleapis.com/maps/api"
        }
        
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return "/weather"
        case .weatherForecast:
            return "/forecast"
        case .placeDetails:
            return "/place/details/json"
        case .placeAutocomplete:
            return "/place/autocomplete/json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .currentWeather, .weatherForecast, .placeDetails, .placeAutocomplete:
            return .get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .currentWeather(let coordinate):
            return [
                "lat": "\(coordinate.latitude)",
                "lon": "\(coordinate.longitude)"
            ]
        case .weatherForecast(let coordinate):
            return [
                "lat": "\(coordinate.latitude)",
                "lon": "\(coordinate.longitude)"
            ]
        case .placeDetails(let placeId):
            return [
                "fields": "geometry",
                "place_id": placeId
            ]
        case .placeAutocomplete(let query):
            return [
                "input": query,
                "types": "(cities)"
            ]
        }
    }
    
    var apiKey: String {
            guard let filePath = Bundle.main.path(forResource: "APIKeys-info", ofType: "plist") else {
                fatalError("Unable to find file named 'APIKeys-info.plist'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            
            switch self {
            case .currentWeather, .weatherForecast:
                guard let value = plist?.object(forKey: "Open Weather Map Api Key") as? String else {
                    fatalError("Unable to find key 'Open Weather Map Api Key' in 'APIKeys-info.plist'")
                }
                
                return value
            case .placeAutocomplete, .placeDetails:
                guard let value = plist?.object(forKey: "Google Places Api Key") as? String else {
                    fatalError("Unable to find key 'Google Places Api Key' in 'APIKeys-info.plist'")
                }
                
                return value
            }
            
        }
    
    var defaultParameters: [String: String]? {
        switch self {
        case .placeDetails, .placeAutocomplete:
            return [
                "key": apiKey
            ]
        default:
            return [
                "appid": apiKey,
                "units": "metric"
            ]
        }
    }
    
    
}

extension ApiRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL().appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
                .encode(parameters, into: request)
        }
        
        if let defaultParams = defaultParameters {
            request = try URLEncodedFormParameterEncoder()
                .encode(defaultParams, into: request)
        }
        
        return request
    }
}
