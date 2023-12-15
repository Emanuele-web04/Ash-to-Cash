//
//  TimerHandling.swift
//  Ash To Cash
//
//  Created by Emanuele Di Pietro on 15/12/23.
//

import SwiftUI

class TimerHandling: ObservableObject {
    
    @Published var timerCount = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var isRunning = false
    @Published var timer: TimeInterval = 0
    
    func startTimer() {
        isRunning = true
    }
    
    func stopAndReset() {
        isRunning = false
        timer = 0
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = (Int(time) / 60) % 60
        let hours = (Int(time) / 3600) % 24
        let days = Int(time) / 86400
        
        return String(format: "%02d:%02d:%02d", days, hours, minutes)
    }
}
