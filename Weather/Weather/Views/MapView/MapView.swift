//
//  MapView.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 01/02/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var favLocations: [Weather]?
    private let toolbarIconSize = 30.0
    
    @State private var region : MKCoordinateRegion
    
    @EnvironmentObject var mapViewModel: MapViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(coordinate : CLLocationCoordinate2D, favLocations: [Weather]?) {
        self.coordinate = coordinate
        self.favLocations = favLocations
        _region = State(initialValue: MKCoordinateRegion(center: coordinate,
                                                         span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
    }
    var body: some View {
        //TODO: Fix display of favorites on map
        NavigationView {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: mapViewModel.favoriteLocations ) {
                MapPin(coordinate: $0.coordinate)
            }
            .ignoresSafeArea()
            .onAppear {
                mapViewModel.getFavoriteLocationDetails(favorites: favLocations ?? [])
            }
            .toolbar {
                /*
                 * There is an issue that needs investigation with Map. You cannot
                 * drag it down to dismiss like the other views that are presented
                 * via ".sheet" property of a Button.
                 * Quick Fix: Adding a toolbar with a ToolbarItem containing another
                 * view inside it (e.g a Button), enables draggin the Map down to
                 * dismiss
                 */
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {}
                        .tint(.white)
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 51.50998, longitude: -0.1337), favLocations: [])
    }
}
