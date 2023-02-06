//
//  SearchPlacesView.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 01/02/2023.
//

import SwiftUI

struct SearchPlacesView: View {
    @State private var query: String = ""
    
    @Binding var selectedPlaceDetails: PlaceDetails?
    
    @ObservedObject var searchPlacesViewModel = SearchPlacesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
            switch searchPlacesViewModel.state {
                case.isLoading:
                ProgressView(NSLocalizedString("LOADING", comment: "")).foregroundColor(.black)
                default:
                    List(searchPlacesViewModel.predictions ?? [], id: \.placeId) { prediction in
                        Text(prediction.description)
                            .onTapGesture {
                                searchPlacesViewModel.fetchPlaceDetails(placeId: prediction.placeId, success: { placeDetails in
                                    self.selectedPlaceDetails = placeDetails
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                            }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationTitle(NSLocalizedString("SEARCH_TITLE", comment: ""))
            .searchable(text: $query)
            .onChange(of: query) { newValue in
                searchPlacesViewModel.fetchPlaceAutocomplete(query: newValue)
            }
        }
    }
}

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesView(
            selectedPlaceDetails: .constant(
                PlaceDetails(
                    result: PlaceResult(
                        geometry: Geometry(
                            location: Location(
                                longitude: -0.1337,
                                latitude: 51.50998
                            )
                        )
                    )
                )
            )
        )
    }
}
