//
//  TimerView.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.03.2023.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timer: FocusTimer
    @State private var isPresentingHistoryView = false
    
    var body: some View {
        VStack {
            if timer.isTimerActive {
                CountdownView()
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
                TimeSelectorView()
                Button(action: {
                    timer.startTimer(for: timer.lengthInMinutes)
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
            if timer.timerType == .breakTimer {
                Button(action: {
                    timer.stopTimer()
                    timer.timerType = .focusTimer
                    timer.lengthInMinutes = 25
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 120, height: 40)
                            .foregroundColor(.teal)
                        Text("Skip")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                }
                .padding(.top)
            }
        }
        .toolbar {
            if !timer.isTimerActive {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingHistoryView = true
                    }) {
                        Image(systemName: "chart.xyaxis.line")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingHistoryView) {
            NavigationView {
                HistoryView(history: timer.history)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isPresentingHistoryView = false
                            }) {
                                Image(systemName: "xmark")
                            }
                        }
                    }
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
