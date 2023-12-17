
import SwiftUI

class TimerHandling: ObservableObject {
    
    @Published var timerCount = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var isRunning = false
    @Published var timer: TimeInterval = 0
    
    init() {
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.saveTimer()
        }

        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.restoreTimer()
        }

        restoreTimer() // Restore the timer when the object is initialized
    }
    
    func startTimer() {
        isRunning = true
    }
    
    func stopAndReset() {
        isRunning = false
        timer = 0
        UserDefaults.standard.removeObject(forKey: "savedTime")
        UserDefaults.standard.removeObject(forKey: "backgroundTime")
    }
    
    private func saveTimer() {
        if isRunning {
            UserDefaults.standard.set(timer, forKey: "savedTime")
            UserDefaults.standard.set(Date(), forKey: "backgroundTime")
        }
    }
    
    private func restoreTimer() {
        if let backgroundTime = UserDefaults.standard.object(forKey: "backgroundTime") as? Date,
           let savedTime = UserDefaults.standard.object(forKey: "savedTime") as? TimeInterval {
            
            let timeElapsed = Date().timeIntervalSince(backgroundTime)
            timer = savedTime + timeElapsed
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = (Int(time) / 60) % 60
        let hours = (Int(time) / 3600) % 24
        let days = Int(time) / 86400
        return String(format: "%02d:%02d:%02d", days, hours, minutes)
    }
}
