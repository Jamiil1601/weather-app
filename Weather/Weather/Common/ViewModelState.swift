//
//  State.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 27/01/2023.
//

import Foundation

enum ViewModelState {
    case none
    case loaded
    case isLoading
    case error
}

protocol ViewModelStateProtocol {
    var state: ViewModelState { get }
}
