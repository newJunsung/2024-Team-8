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
            ZStack {
                Color.primary.ignoresSafeArea()
                VStack(alignment: .center, spacing: 28) {
                    
                    HStack {
                        Spacer()
                        NavigationLink(destination: TimerView(timeInput: $timeInput)) {
                            Text("그만 두기")
                                .frame(width: 63, height: 20)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .font(.system(size: 13, weight: .medium))
                        }
                        .padding(.trailing, 20)
                        .buttonStyle(PlainButtonStyle())
                        .navigationBarBackButtonHidden()
                        
                    }.offset(x: 0, y: -20)
                    
                    ZStack {
                        Circle()
                            .stroke(Color(red: 0.23, green: 0.23, blue: 0.24),lineWidth: 5)
                            .opacity(0.3)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(timeRemaining / (Double(timeInput) ?? 1) / 60))
                            .stroke(style: StrokeStyle(lineWidth: 5,  lineJoin: .round))
                            .rotationEffect(.degrees(-90))
                            .foregroundColor(.orange)
                        
                        VStack {
                            Text(formattedTime(time: timeRemaining))
                                .foregroundStyle(Color.white)
                                .font(.system(size: 96, weight: .regular))
                            
                        }
                    }
                    .frame(maxWidth: 360)
                    
                    
                    
                    HStack {
                        Text("돌아올 시간")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 22, weight: .bold))
                        
                        if let endTime = endTime {
                            Text(" \(formattedEndTime(endTime))")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 22, weight: .regular))
                        }
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
    TimerView(timeInput: .constant("1"))
        .frame(width: 600, height: 572)
}

