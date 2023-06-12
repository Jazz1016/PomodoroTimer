//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by James Lea on 6/12/23.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    // MARK: Since we're doing background fetching initializing here
    @StateObject var pomodoroModel: PomodoroModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
    }
}
