//
//  TimerView.swift
//  Team8
//
//  Created by dora on 6/15/24.
//

import SwiftUI

struct TimerView: View {
    
    /// ✏️ (수정) 입력뷰에서 받아올 값
    @Binding var timeInput: String
    
    @State private var timeRemaining: TimeInterval = 0
    
    /// ✏️ (수정) 축적할 값 : UserDefault 사용?
    ///@State private var timeAccumulated: TimeInterval = 0
    
    @State private var endTime: Date? = nil
    
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 5)
                        .opacity(0.3)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(timeRemaining / (Double(timeInput) ?? 1) / 60))
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                        .foregroundColor(.orange)
                    
                    VStack {
                        Text(formattedTime(time: timeRemaining))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                    }
                }
                .frame(maxWidth: 500)
                
                if let endTime = endTime {
                    Text("돌아올 시간: \(formattedEndTime(endTime))")
                        .font(.title2)
                }

            }
            .padding(.horizontal, 30)
            .navigationTitle("Timer")
            .onAppear {
                startTimer()
            }
        }
    }
}

extension TimerView {
    /// 🕰️ TimeFormat  🕰️
    private func formattedTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        /// MM:SS
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func formattedEndTime(_ endTime: Date) -> String {
        let dateFormatter = DateFormatter()
        
        // 형식 HH:MM AM/PM
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: endTime)
    }
    
    /// ⏲️ Timer  ⏲️
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
 
    private func startTimer() {
        guard let inputTime = Double(timeInput), inputTime > 0 else {
            isRunning = false
            return
        }
        
        timeRemaining = inputTime * 60
        endTime = Date().addingTimeInterval(timeRemaining)
        
        /// 1초 간격으로 time이 0이 될 때까지 실행!
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
        isRunning = true
    }
}

#Preview {
    TimerView(timeInput: .constant("15"))
        .frame(minWidth: 600, idealWidth: 600, maxWidth: 600, minHeight: 572, idealHeight: 572, maxHeight: 572)
}

