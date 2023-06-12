//
//  PomodoroModel.swift
//  PomodoroTimer
//
//  Created by James Lea on 6/12/23.
//

import Foundation

class PomodoroModel: NSObject, ObservableObject {
    // MARK: Timer Properties
    @Published var progress: CGFloat = 1
    @Published var timerValueString: String = "00:00"
    @Published var isStarted: Bool = false
    @Published var addNewTimer: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    
}
