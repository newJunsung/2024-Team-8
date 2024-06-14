//
//  Team8App.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import SwiftUI

@main
struct Team8App: App {
    @StateObject private var gaManager = GroupActivityManager()
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(gaManager)
        }
        .windowResizability(.contentSize)
    }
}
