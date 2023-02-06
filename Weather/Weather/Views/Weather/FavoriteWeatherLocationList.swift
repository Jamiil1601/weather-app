//
//  FavoriteWeatherLocationList.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 02/02/2023.
//

import SwiftUI
import CoreLocation

struct FavoriteWeatherLocationList: View {
    var coordinate: CLLocationCoordinate2D
    @State var weatherFavorites: [Weather] = []
    @State var isMapViewPresented = false
    
    private let toolbarIconSize = 30.0
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @Inject var favoriteWeatherLocationStore: FavoriteWeatherLocationStoreProtocol
    
    var body: some View {
        NavigationView {
            List(weatherFavorites, id: \.name) { weather in
                Text(weather.name ?? "")
                    .onTapGesture {
                        if let coordinate = weather.coordinate?.coordinate2D {
                            weatherViewModel.fetchCurrentWeather(coordinate: coordinate)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                
            }
            .navigationTitle(NSLocalizedString("WEATHER_FAVORITES", comment: ""))
            .onAppear {
                favoriteWeatherLocationStore.load { result in
                    switch result {
                    case .success(let favorites):
                        self.weatherFavorites = favorites
                    case .failure(_):
                        break
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        isMapViewPresented.toggle()
                    } label: {
                        VStack {
                            Text(NSLocalizedString("VIEW_ON_MAP", comment: ""))
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .light))
                            
                            Image(systemName: "map")
                                .resizable()
                                .frame(width: toolbarIconSize, height: toolbarIconSize)
                        }
                    }
                    .tint(.black)
                    .sheet(
                        isPresented: $isMapViewPresented,
                        onDismiss: {
                            isMapViewPresented = false
                            
                        },
                        content: { MapView(coordinate: coordinate, favLocations: weatherFavorites) }
                    )
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
