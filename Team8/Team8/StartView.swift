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
                    Task {
                        for await session in RestTogether.sessions() {
                            print("get session")
                            gaManager.sessionJoined(session)
                        }
                        try? await gaManager.send(.init(id: UUID(), step: .enterRoom))
                    }
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
                case .voteToRest(_, _):
                    VoteLoadingView()
                case .readyToRest(let minutes):
                    JustRabbitView(imageResource: .startRabbit, text: "\(minutes)분 뒤에 돌아오세요.", buttonText: "확인") {
                        Task {
                            try? await gaManager.send(.init(id: UUID(), step: .startToRest(minutes: minutes)))
                        }
                    }
                case .startToRest(let minutes):
                    TimerView(timeInput: "\(minutes)")
                case .failToRest:
                    JustRabbitView(imageResource: .startRabbit, text: "기각!\n돌아가서 작업을 계속 합시다.", buttonText: "확인") {
                        gaManager.goToEnter()
                    }
                case .finishRest:
                    JustRabbitView(imageResource: .startRabbit, text: "다시 화이팅!", buttonText: "네넹넴넵") {
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
