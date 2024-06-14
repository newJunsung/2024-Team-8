//
//  Team8App.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import SwiftUI

@main
struct Team8App: App {
    var body: some Scene {
        WindowGroup {
            TimerView(timeInput: .constant("15"))
        }
    }
}
