//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by James Lea on 6/12/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    var body: some View {
        HomeView()
            .environmentObject(pomodoroModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
