//
//  DependencyInjection.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 30/01/2023.
//

import Foundation
import Swinject

final class DependencyInjection {
    static var shared = DependencyInjection()
    
    private var _container: Container?
    
    var container: Container {
        get {
            if _container == nil {
                _container = buildContainer()
            }
            
            return _container!
        }
        
        set {
            _container = newValue
        }
    }
    
    private func buildContainer() -> Container {
        let container = Container()
        
        container.register(LocationManagerProtocol.self) { _ in
            return LocationManager()
        }
        
        container.register(ApiManagerProtocol.self) { _ in
            return ApiManager()
        }
        
        container.register(FavoriteWeatherLocationStoreProtocol.self) { _ in
            return FavoriteWeatherLocationStore()
        }
        
        return container
    }
}

@propertyWrapper
struct Inject<T> {
    let wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyInjection.shared.container.resolve(T.self)!
    }
}
