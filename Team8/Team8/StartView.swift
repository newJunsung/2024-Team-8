//
//  StartView.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
            .background(configuration.isPressed ? Color.white : Color.blue)
            .cornerRadius(6.0)
            .padding()
    }
}

struct StartView: View {
    @EnvironmentObject private var gaManager: GroupActivityManager
    
    var body: some View {
        NavigationStack(path: $gaManager.path) {
            ZStack(alignment: .bottom) {
                Image(.startRabbit)
                
                VStack {
                    Text("쉴래빗")
                        .font(.system(size: 64, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                    Spacer()
                }
                Button(action: {
                    gaManager.appendStep(.enterRoom)
                }) {
                    Text("􁃑 그룹 모으기")
                        .frame(maxWidth: 200, maxHeight: 29)
                }
                .buttonStyle(BlueButtonStyle())
            }
            .frame(width: 600, height: 572, alignment: .center)
            .background(Color.primary)
            .navigationDestination(for: VoteStep.self) { step in
                switch step {
                case .enterRoom:
                    TimeInputView()
                case .wantToRest(let minutes):
                    VoteView(minutes: minutes)
                case .voteToRest(let argree, let disagree):
                    VoteLoadingView()
                case .startToRest(let minutes):
                    TimerView(timeInput: "\(minutes)")
                default:
                    JustRabbitView(imageResource: .tokki, text: "다시 화이팅!", buttonText: "네넹넴넵") {
                        gaManager.goToEnter()
                    }
                }
            }
        }
    }
}

#Preview {
    StartView()
        .environmentObject(GroupActivityManager())
}
