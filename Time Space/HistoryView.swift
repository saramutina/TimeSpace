//
//  HistoryView.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.04.2023.
//

import SwiftUI

struct HistoryView: View {
    let history: [History]
    
    var body: some View {
        VStack {
            Text("You've focused for **\(minutesFocusedToday)** minutes today!")
                .padding(.bottom)
            Text("Totally you've focused for **\(totalMinutesFocused)** minutes with this app!")
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

extension HistoryView {
    private var totalMinutesFocused: Int {
        var totalMinutes = 0
        history.forEach { focusTime in
            totalMinutes += focusTime.minutesFocused
        }
        return totalMinutes
    }
    
    private var minutesFocusedToday: Int {
        var minutesToday = 0
        for focusTime in history {
            if Calendar.current.isDateInToday(focusTime.date) {
                minutesToday += focusTime.minutesFocused
            }
        }
        return minutesToday
    }
}

struct HistoryView_Previews: PreviewProvider {
    static let today = Date()
    static let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: today)!
    static let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
    
    static var previews: some View {
        HistoryView(history: [
            History(date: twoDaysAgo, minutesFocused: 20),
            History(date: twoDaysAgo, minutesFocused: 15),
            History(date: twoDaysAgo, minutesFocused: 12),
            History(date: yesterday, minutesFocused: 25),
            History(date: yesterday, minutesFocused: 60),
            History(date: today, minutesFocused: 15)
        ])
    }
}
