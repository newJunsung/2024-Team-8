//
//  GroupActivityManager.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import GroupActivities
import SwiftUI

@MainActor
final class GroupActivityManager: ObservableObject {
    private var session: GroupSession<RestTogether>?
    private var messenger: GroupSessionMessenger?
    
    @Published var agreeToRest = 0
    @Published var disagreeToRest = 0
    
    private func sessionJoined(_ session: GroupSession<RestTogether>) {
        if session.state != .joined { session.join() }
        messenger = GroupSessionMessenger(session: session)
        listenToMessages()
    }
    
    private func listenToMessages() {
        guard let messenger else { return }
        Task.detached {
            for await (message, _) in messenger.messages(of: VoteMessage.self) {
                switch message.step {
                case .enterRoom:
                    print("path에 enterRoom 추가")
                    print("_ 분 쉬고 싶어요 뷰")
                case .wantToRest(let minutes):
                    print("path에 wantToRest 추가")
                    print("찬성 반대 뷰")
                case .voteToRest(let argree, let disagree):
                    print("찬성 반대 분기처리")
                    print("아직 투표 중이에요. 뷰")
                case .startToRest(let minutes):
                    print("누구 하나가 누르면 초 재기 시작")
                    print("15분 뒤에 돌아오세요 뷰")
                case .failToRest:
                    print("누구 하나가 누르면 메인으로 돌아감?")
                    print("돌아가서 작업을 계속 합시다 뷰")
                case .finishRest:
                    print("다시 화이팅! 뷰")
                }
            }
        }
    }
    
    func send(_ message: VoteMessage) async throws {
        try await messenger?.send(message)
    }
}
