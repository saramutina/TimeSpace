//
//  TimerView.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.03.2023.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timer: FocusTimer
    
    var body: some View {
        VStack {
            if timer.isTimerActive {
                CountdownView()
            } else {
                TimeSelectorView()
            }
            if timer.isTimerActive {
                Button(action: {
                    timer.stopTimer()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 120, height: 40)
                            .foregroundColor(.teal)
                        Text("Stop")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .padding(.top, 60)
            } else {
                Button(action: {
                    timer.startTimer()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 120, height: 40)
                            .foregroundColor(.teal)
                        Text("Start")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .padding(.top, 60)
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var timer = FocusTimer(lengthInMinutes: 20)
    static var previews: some View {
        TimerView()
            .environmentObject(timer)
    }
}
