//
//  ContentView.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 21/01/2023.
//

import SwiftUI
import Combine
import CoreLocation

struct ContentView: View {
    @Inject private var locationManager: LocationManagerProtocol
    
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @ObservedObject var weatherForecastViewModel = WeatherForecastViewModel()
    @ObservedObject var mapViewModel = MapViewModel()
    
    @State var cancellables: Set<AnyCancellable> = []
    @State var alertItem: AlertItem?
    @State var selectedPlaceDetails: PlaceDetails?
    @State var isSearchScreenPresented = false
    @State var isMapViewPresented = false
    @State var isFavoriteScreenPresented = false
    @State private var query: String = ""
    
    //To pass to map
    @State private var coordinate: CLLocationCoordinate2D?
    
    private let toolbarIconSize = 30.0
    
    var body: some View {
        /*
         * NavigationView will deprecate in future IOS version. Consider using
         * NavigationStack (available in IOS 16 or newer)
         */
        NavigationView {
            ZStack {
                Color(weatherViewModel.weatherColor)
                    .edgesIgnoringSafeArea(.top)
                switch weatherViewModel.state {
                case.loaded:
                    
                    VStack(spacing: 0) {
                        WeatherView()
                        
                        WeatherForecastView()
                    }
                default:
                    ProgressView(NSLocalizedString("LOADING", comment: ""))
                }
            }.onAppear {
                locationManager.authorizationStatus
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        print("TODO handle completion")
                    } receiveValue: { status in
                        print("Received")
                        switch status {
                        case .denied, .notDetermined, .restricted:
                            alertItem = AlertItem(
                                title: Text(NSLocalizedString("PERMISSION_DENIED_TITLE", comment: "")),
                                desc: Text(NSLocalizedString("LOCATION_PERMISSION_DENIED", comment: "")),
                                primaryBtn: .default(Text(NSLocalizedString("OK", comment: "")), action: {
                                    if let url = URL(string:UIApplication.openSettingsURLString) {
                                        UIApplication.shared.open(url)
                                    }
                                })
                            )
                            
                        default:
                            break
                        }
                    }.store(in: &cancellables)
                
                locationManager.coordinate
                    .receive(on: DispatchQueue.main)
                    .first(where: { $0 != nil })
                    .sink { completion in
                        print("TODO handle completion")
                    } receiveValue: { coordinate in
                        if let coord = coordinate {
                            locationManager.stopUpdatingLocation()
                            self.weatherViewModel.fetchCurrentWeather(coordinate: coord)
                            self.weatherForecastViewModel.fetchWeatherForecast(coordinate: coord)
                            self.coordinate = coord
                        }
                    }.store(in: &cancellables)
            }
            .alert(item: $alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.desc,
                      dismissButton: alertItem.primaryBtn
                )
            })
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isSearchScreenPresented.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: toolbarIconSize, height: toolbarIconSize)
                    }
                    .tint(.white)
                    .sheet(
                        isPresented: $isSearchScreenPresented,
                        onDismiss: {
                            isSearchScreenPresented = false
                            
                            if let location = selectedPlaceDetails?.result.geometry.location {
                                weatherViewModel.fetchCurrentWeather(coordinate: location.coordinate2D)
                            }
                        },
                        content: { SearchPlacesView(selectedPlaceDetails: $selectedPlaceDetails) }
                    )
                }
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            isMapViewPresented.toggle()
                        } label: {
                            Image(systemName: "map")
                                .resizable()
                                .frame(width: toolbarIconSize, height: toolbarIconSize)
                        }
                        .tint(.black)
                        .sheet(
                            isPresented: $isMapViewPresented,
                            onDismiss: {
                                isMapViewPresented = false
                                
                            },
                            content: { MapView(coordinate: coordinate!, favLocations: []) }
                        )
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            weatherViewModel.toggleFavorite()
                        } label: {
                            Image(systemName: weatherViewModel.currentWeather?.isFavorited ?? false ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: toolbarIconSize, height: toolbarIconSize)
                                .tint(weatherViewModel.currentWeather?.isFavorited ?? false ? .pink : .black)
                        }
                        .tint(.black)
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            isFavoriteScreenPresented.toggle()
                        } label: {
                            Image(systemName: "heart.text.square")
                                .resizable()
                                .frame(width: toolbarIconSize, height: toolbarIconSize)
                        }
                        .tint(.black)
                        .sheet(
                            isPresented: $isFavoriteScreenPresented,
                            onDismiss: {
                                isFavoriteScreenPresented = false
                                
                            },
                            content: {
                                FavoriteWeatherLocationList(coordinate: coordinate!)
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .tint(.black)
            .edgesIgnoringSafeArea(.all)
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(weatherViewModel)
        .environmentObject(weatherForecastViewModel)
        .environmentObject(mapViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
