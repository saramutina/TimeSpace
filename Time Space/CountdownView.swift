//
//  CountdownView.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.03.2023.
//

import SwiftUI

struct CountdownView: View {
    @EnvironmentObject var timer: FocusTimer
    
    var body: some View {
        Text(String(format: "%02d:%02d", timer.minutes, timer.seconds))
            .font(.title)
    }
}

struct CountdownView_Previews: PreviewProvider {
    static let timer = FocusTimer(lengthInMinutes: 20)
    static var previews: some View {
        CountdownView()
            .environmentObject(timer)
    }
}
