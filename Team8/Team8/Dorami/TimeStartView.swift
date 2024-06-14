//
//  TimeStartView.swift
//  Team8
//
//  Created by dora on 6/15/24.
//

import SwiftUI

struct StartView: View {
    @State private var timeInput: String = ""
    
    var body: some View{
        NavigationStack{
            VStack {
                Text("\(timeInput)분 뒤에 돌아오세요!")
                
                TextField("입력하세요", text: $timeInput)
                    .padding()
                    .padding(.horizontal, 20)
                
                NavigationLink(destination: TimerView(timeInput: timeInput)) {
                    Text("start")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Start Timer")
            .padding()
        }
    }
}
