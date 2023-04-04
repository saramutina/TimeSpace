//
//  TimeSelectorView.swift
//  Time Space
//
//  Created by Katie Saramutina on 28.03.2023.
//

import SwiftUI

struct TimeSelectorView: View {
    @EnvironmentObject var timer: FocusTimer
    
    @State var angleValue: CGFloat = 150.0
    
    var config: RoundSelectorConfig {
        switch timer.timerType {
        case .focusTimer:
            return RoundSelectorConfig(
                minimumValue: 1.0,
                maximumValue: 61.0,
                totalValue: 61.0,
                knobRadius: 15.0,
                raduis: 120.0)
        case .breakTimer:
            return RoundSelectorConfig(
                minimumValue: 1.0,
                maximumValue: 21.0,
                totalValue: 21.0,
                knobRadius: 15.0,
                raduis: 120.0)
        }
    }
    
    var body: some View {
        VStack {
            Text(timer.timerType.selectingTimeMessage)
                .font(.title)
                .padding(.bottom, 60)
                .multilineTextAlignment(.center)
            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(timer.lengthInMinutes) / config.totalValue)
                    .stroke(Color.green, lineWidth: 12)
                    .frame(width: config.raduis * 2, height: config.raduis * 2)
                    .rotationEffect(.degrees(-90))
                Circle()
                    .fill(Color.teal)
                    .frame(width: config.knobRadius * 2, height: config.knobRadius * 2)
                    .padding(10)
                    .offset(y: -config.raduis)
                    .rotationEffect(Angle.degrees(Double(
                        (timer.lengthInMinutes * 360 / (Int(config.maximumValue) - 1))
                    )))
                    .gesture(DragGesture(minimumDistance: 0.0)
                        .onChanged({value in
                            change(location: value.location)
                        }))
                Text("\(timer.lengthInMinutes) minutes")
            }
        }
        .onAppear {
            switch timer.timerType {
            case .focusTimer:
                timer.lengthInMinutes = 25
                angleValue = 150.0
            case .breakTimer:
                timer.lengthInMinutes = 5
                angleValue = 90.0
            }
        }
    }
}

extension TimeSelectorView {
    private func change(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: location.y)
        // angle in radians
        let angle = atan2(vector.dy - (config.knobRadius + 10), vector.dx - (config.knobRadius + 10)) + .pi/2.0
        // angle(-π to π) -> angle(0 to 2π)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // angle from total value
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
        
        if value >= config.minimumValue && value <= config.maximumValue {
            timer.lengthInMinutes = Int(value)
            // angle in degrees
            angleValue = fixedAngle * 180 / .pi
        }
    }
}

extension TimeSelectorView {
    struct RoundSelectorConfig {
        let minimumValue: CGFloat
        var maximumValue: CGFloat
        var totalValue: CGFloat
        let knobRadius: CGFloat
        let raduis: CGFloat
    }
}

struct TimeSelectorView_Previews: PreviewProvider {
    static var timer = FocusTimer(lengthInMinutes: 20)
    
    static var previews: some View {
        TimeSelectorView()
            .environmentObject(timer)
    }
}
