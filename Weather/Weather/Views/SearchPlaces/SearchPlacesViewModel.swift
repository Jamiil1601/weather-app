//
//  SearchPlacesViewModel.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 01/02/2023.
//

import Foundation
import Combine

final class SearchPlacesViewModel: ViewModelStateProtocol, ObservableObject {
    @Inject private var apiManager: ApiManagerProtocol
        
    @Published var state: ViewModelState = .none
    @Published var predictions: [Place]?
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    func fetchPlaceAutocomplete(query: String) {
        state = .isLoading
                
        cancellableSet.forEach({ $0.cancel() })
        
        apiManager.fetchPlaceAutocomplete(query: query)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    self?.predictions = dataResponse.value?.predictions
                } else {
                    //TODO: Display alert
                    self?.state = .error
                }
            }.store(in: &cancellableSet)
    }
    
    func fetchPlaceDetails(placeId: String, success: @escaping (_ placeDetails: PlaceDetails?) -> Void) {
        state = .isLoading
        
        apiManager.fetchPlaceDetails(placeId: placeId)
            .sink { [weak self] dataResponse in
                if dataResponse.error == nil {
                    self?.state = .loaded
                    
                    success(dataResponse.value)
                } else {
                    //TODO: Display alert
                    self?.state = .error
                }
            }.store(in: &cancellableSet)
    }
        
        public init () {}
}
