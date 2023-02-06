//
//  TemperatureView.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 27/01/2023.
//

import SwiftUI

struct TemperatureView: View {
    var temperature: Double
    var label: String?
    var tempSize: CGFloat
    var labelSize: CGFloat
    var offset: CGFloat?
    
    var body: some View {
        VStack {
            Text.temperatureText(temp: temperature, size: tempSize)
                .offset(x: offset ?? 0)
            Text(label ?? "")
                .font(.system(size: labelSize))
                .foregroundColor(.white)
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(temperature: 25, tempSize: 72, labelSize: 45)
    }
}
