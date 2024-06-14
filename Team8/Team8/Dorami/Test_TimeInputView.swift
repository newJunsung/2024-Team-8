//
//  Test_TimeInputView.swift
//  Team8
//
//  Created by dora on 6/15/24.
//

import SwiftUI

struct TimeInputView: View {
    @State private var timeInput: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                HStack{
                    Spacer()
                    TextField("입력하세요", text: $timeInput)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    Text("분 쉬고 싶어요!")
                    Spacer()
                }
                
                
                NavigationLink(destination: StartTimeView(timeInput: $timeInput)) {
                    Text("요청하기")
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .navigationTitle("Gravity")
        }
    }
}

#Preview{
    TimeInputView()
}

