//
//  FocusTimer.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.03.2023.
//

import Foundation

class FocusTimer: ObservableObject {
    @Published var lengthInMinutes: Int
    @Published var isTimerActive: Bool = false
    @Published var timerType: TimerType = .focusTimer
    private var secondsRemaining: Int
    
    init(lengthInMinutes: Int = 0) {
        self.lengthInMinutes = lengthInMinutes
        self.secondsRemaining = lengthInMinutes * 60
    }
    
    var minutes: Int {
        secondsRemaining / 60
    }
    var seconds: Int {
        secondsRemaining % 60
    }
    
    private var timer: Timer?
    
    func startTimer(for lengthInMinutes: Int) {
        isTimerActive = true
        self.lengthInMinutes = lengthInMinutes
        self.secondsRemaining = lengthInMinutes * 60
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.isTimerActive = true
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
            } else {
                switch self.timerType {
                case .focusTimer:
                    self.timerType = .breakTimer
                case .breakTimer:
                    self.timerType = .focusTimer
                }
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerActive = false
    }
}

extension FocusTimer {
    enum TimerType {
        case focusTimer
        case breakTimer
        
        var selectingTimeMessage: String {
            switch self {
            case .focusTimer:
                return "Choose focus session time:"
            case .breakTimer:
                return "Well done 👏 You can take a short break:"
            }
        }
        
        var timerOnMessage: String {
            switch self {
            case .focusTimer:
                return "💪 Keep it up!"
            case .breakTimer:
                return "☕️ Taking a break."
            }
        }
    }
}
