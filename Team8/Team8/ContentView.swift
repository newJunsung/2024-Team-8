//
//  ContentView.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import SwiftUI

struct ContentView: View {
    @State var showDialog = false
    @StateObject var manager = GroupActivityManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
