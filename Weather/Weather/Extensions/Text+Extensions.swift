//
//  Text+Extensions.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 23/01/2023.
//

import SwiftUI

extension Text {
    static func temperatureText(temp: Double?, size: CGFloat) -> some View {
        let tempFont = UIFont.systemFont(ofSize: size, weight: .semibold)
        let tempValueAttrs = AttributeContainer([
            .font: tempFont,
            .foregroundColor: UIColor.white
        ])
        
        let temperature = temp == nil
        ? "--"
        : String(format: "%.0f", temp ?? 0)
        
        var tempString = AttributedString(temperature, attributes: tempValueAttrs)
        
        let symbolFont = UIFont.systemFont(ofSize: size, weight: .light)
        let degSymbolAttrs = AttributeContainer([
            .font: symbolFont,
            .foregroundColor: UIColor.white
        ])
        
        let degreeSymbol = AttributedString("°", attributes: degSymbolAttrs)
        
        tempString.append(degreeSymbol)
        
        
        return Text(tempString)
    }
}
