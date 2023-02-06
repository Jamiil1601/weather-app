//
//  WeatherView.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 22/01/2023.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    let margin = 14.0
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(spacing: 0) {
            weatherViewModel.weatherImage?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth)
                .overlay(
                    VStack(spacing: 0) {
                        HStack {
                            Text("\(weatherViewModel.cityName ?? "")")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                        TemperatureView(
                            temperature: weatherViewModel.temperature?.currentTemp ?? 0 ,
                            label: weatherViewModel.currentWeather?.weatherConditions.first?.label.uppercased(),
                            tempSize: 72,
                            labelSize: 24,
                            offset: 16
                        )
                        .frame(width: 200, alignment: .top)
                    }
                )
            
            HStack {
                TemperatureView(
                    temperature: weatherViewModel.temperature?.minTemp ?? 0,
                    label: NSLocalizedString("MIN", comment: ""),
                    tempSize: 18,
                    labelSize: 18,
                    offset: 5
                )
                TemperatureView(
                    temperature: weatherViewModel.temperature?.currentTemp ?? 0,
                    label: NSLocalizedString("CURRENT", comment: ""),
                    tempSize: 18,
                    labelSize: 18,
                    offset: 5
                )
                    .frame(maxWidth: .infinity)
                TemperatureView(
                    temperature: weatherViewModel.temperature?.maxTemp ?? 0,
                    label: NSLocalizedString("MAX", comment: ""),
                    tempSize: 18,
                    labelSize: 18,
                    offset: 5
                )
            }
            .padding(EdgeInsets(top: 0, leading: margin, bottom: margin, trailing: margin))
            
            Divider()
                .frame(height: 2)
                .overlay(.white)
            
        }
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

