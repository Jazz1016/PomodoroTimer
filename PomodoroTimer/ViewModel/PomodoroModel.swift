//
//  PomodoroModel.swift
//  PomodoroTimer
//
//  Created by James Lea on 6/12/23.
//

import SwiftUI

class PomodoroModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    // MARK: Timer Properties
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    private var endDate: Date = Date()
    var originalDiff: Int = 0
    var counter = 1
    
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    // MARK: Post Timer Properties
    @Published var isFinished: Bool = false
    
    // MARK: Since its NSObject
    override init () {
        super.init()
        self.authorizeNotification()
    }
    
    // MARK: Request Notification Access
    func authorizeNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { _, _ in
            
        }
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
    
    // MARK: Starting Timer
    func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)){isStarted = true}
        
        endDate = Date()
        endDate = Calendar.current.date(byAdding: .minute, value: minutes, to: endDate)!
        endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
        addNewTimer = false
        
        
        // MARK: Setting String Time Value
        timerStringValue = "\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
        print("endofstarttimer", endDate)
        // MARK: Calculating Total Seconds For Timer Animation
//        addNotification()
    }
    
    // MARK: Stopping Timer
    func stopTimer() {
        withAnimation {
            isStarted = false
            minutes = 0
            seconds = 0
            progress = 1
        }
        timerStringValue = "00:00"
    }
    
    // MARK: Updating Timer
    func updateTimer() {
        guard isStarted else { return }
        
        let now = Date()
        let diff = endDate.timeIntervalSince1970 + 2 - now.timeIntervalSince1970
        
        if counter == 1 {
            originalDiff = Int(diff)
        }
        counter += 1
        progress = Double(Int(diff))/Double(originalDiff)
        print("progress", progress, "D", diff, "OD", originalDiff)
        
        if diff <= 0 {
            self.isStarted = false
            self.timerStringValue = "0:00"
            self.counter = 1
            return
        }
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        minutes = calendar.component(.minute, from: date)
        seconds = calendar.component(.second, from: date)
        
//        self.minutes = tempMinutes
//        self.seconds = tempSeconds
        self.timerStringValue = String(format:"%d:%02d", minutes, seconds)
    }
    
//    func addNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Pomodoro Timer"
//        content.subtitle = "Congratulations You did it hooray!!!"
//        content.sound = UNNotificationSound.default
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))
//
//        UNUserNotificationCenter.current().add(request)
//    }
    
}

//class PomodoroModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
//    // MARK: Timer Properties
//    @Published var progress: CGFloat = 1
//    @Published var timerStringValue: String = "00:00"
//    @Published var isStarted: Bool = false
//    @Published var addNewTimer: Bool = false
//
//    @Published var hour: Int = 0
//    @Published var minutes: Int = 0
//    @Published var seconds: Int = 0
//
//    // MARK: Total Seconds
//    @Published var totalSeconds: Int = 0
//    @Published var staticTotalSeconds: Int = 0
//
//    // MARK: Post Timer Properties
//    @Published var isFinished: Bool = false
//
//    // MARK: Since its NSObject
//    override init () {
//        super.init()
//        self.authorizeNotification()
//    }
//
//    // MARK: Request Notification Access
//    func authorizeNotification() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { _, _ in
//
//        }
//
//        UNUserNotificationCenter.current().delegate = self
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.sound, .banner])
//    }
//
//    // MARK: Starting Timer
//    func startTimer() {
//        withAnimation(.easeInOut(duration: 0.25)){isStarted = true}
//        // MARK: Setting String Time Value
//        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
//        // MARK: Calculating Total Seconds For Timer Animation
//        totalSeconds = (hour * 3600) + (minutes * 60) + seconds
//        staticTotalSeconds = totalSeconds
//        addNewTimer = false
//        addNotification()
//    }
//
//    // MARK: Stopping Timer
//    func stopTimer() {
//        withAnimation {
//            isStarted = false
//            hour = 0
//            minutes = 0
//            seconds = 0
//            progress = 1
//        }
//        totalSeconds = 0
//        staticTotalSeconds = 0
//        timerStringValue = "00:00"
//    }
//
//    // MARK: Updating Timer
//    func updateTimer() {
//        totalSeconds -= 1
//        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
//        progress = (progress < 0 ? 0 : progress)
//        // 60 minutes * 60 seconds
//        hour = totalSeconds / 3600
//        minutes = (totalSeconds / 60) % 60
//        seconds = (totalSeconds % 60)
//        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
//        if hour == 0 && minutes == 0 && seconds == 0 {
//            isStarted = false
//            isFinished = true
//        }
//    }
//
//    func addNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Pomodoro Timer"
//        content.subtitle = "Congratulations You did it hooray!!!"
//        content.sound = UNNotificationSound.default
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))
//
//        UNUserNotificationCenter.current().add(request)
//    }
//
//}
