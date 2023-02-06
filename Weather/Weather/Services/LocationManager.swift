//
//  LocationManager.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 27/01/2023.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManagerProtocol {
    var coordinate: PassthroughSubject<CLLocationCoordinate2D?, Error> { get }
    var authorizationStatus: PassthroughSubject<CLAuthorizationStatus, Error> { get }
        
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

class LocationManager: NSObject, LocationManagerProtocol, ObservableObject {
    private let locationManager = CLLocationManager()
    
    var coordinate = PassthroughSubject<CLLocationCoordinate2D?, Error>()
    var authorizationStatus = PassthroughSubject<CLAuthorizationStatus, Error>()
    @Published var isLoading = false
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        return self.locationManager.startUpdatingLocation()
    }
        
    func stopUpdatingLocation() {
        return self.locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        self.coordinate.send(location.coordinate)
        self.isLoading = false
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus.send(manager.authorizationStatus)
        }
                
        switch manager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            break
        default:
            startUpdatingLocation()
        }
    }
}
