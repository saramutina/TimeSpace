//
//  Time_SpaceApp.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.03.2023.
//

import SwiftUI

@main
struct Time_SpaceApp: App {
    @StateObject var timer: FocusTimer = FocusTimer(lengthInMinutes: 15)
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                TimerView()
                    .environmentObject(timer)
            }
        }
    }
}
