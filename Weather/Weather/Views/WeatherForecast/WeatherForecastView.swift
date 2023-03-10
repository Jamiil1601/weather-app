//
//  WeatherForecastView.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 22/01/2023.
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherForecastViewModel: WeatherForecastViewModel
    
    let margin = 14.0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(weatherForecastViewModel.weatherForecasts ?? [], id: \.date) {
                    weather in
                    WeatherForecastRow(weather: weather)
                }
            }
            .padding(EdgeInsets(top: margin, leading: margin, bottom: margin * 10, trailing: margin))
        }
        .frame(height: UIScreen.main.bounds.height / 2)
    }
}

struct WeatherForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
