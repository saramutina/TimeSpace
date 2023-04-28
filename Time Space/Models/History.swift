//
//  History.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.04.2023.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var minutesFocused: Int
    
    init(id: UUID = UUID(), date: Date = Date(), minutesFocused: Int) {
        self.id = id
        self.date = date
        self.minutesFocused = minutesFocused
    }
}
