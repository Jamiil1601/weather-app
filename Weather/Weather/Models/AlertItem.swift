//
//  AlertItem.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 31/01/2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title = Text("")
    var desc: Text?
    var primaryBtn: Alert.Button?
    var secondaryBtn: Alert.Button?
}
