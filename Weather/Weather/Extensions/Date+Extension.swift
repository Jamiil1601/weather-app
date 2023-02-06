//
//  Date+Extension.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 25/01/2023.
//

import SwiftUI

extension Date {
    var weekDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        return formatter.string(from: self)
    }
}
