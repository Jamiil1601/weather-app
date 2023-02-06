//
//  WeatherForecastRow.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 22/01/2023.
//

import SwiftUI

struct WeatherForecastRow: View {
    
    //Takes a DailyWeather as parameter which will then be used to fill in the below day of the week text, weather condition icon and temperature text
    var weather: DailyWeather
    
    var body: some View {
            HStack {
                //day of the week text
                Text(weather.date.weekDay)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                //weather condition icon
                weather.weatherConditionIcon?
                    .resizable()
                    .frame(width: 32, height: 32)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                //temperature text
                Text.temperatureText(temp: weather.temperature, size: 18)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(height: 64)
    }
}

struct WeatherForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        let weather = DailyWeather(date: .now, weatherConditionIcon: Image("rainIcon"), temperature: 32)
        WeatherForecastRow(weather: weather)
    }
}
