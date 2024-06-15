//
//  GroupActivityManager.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import Combine
import GroupActivities
import SwiftUI

@MainActor
final class GroupActivityManager: ObservableObject {
    @Published var path = [VoteStep]()
    
    func appendStep(_ step: VoteStep) {
        path.append(step)
    }
    
    func goToRoot() {
        path = []
    }
    
    func goToEnter() {
        path = [.enterRoom]
    }
    
    private var session: GroupSession<RestTogether>?
    private var messenger: GroupSessionMessenger?
    
    private(set) var participantCount = 2
    private var cancellables = Set<AnyCancellable>()
    
    let totalMinutes = 240
    var currentRestTime = 0
    
    private(set) var minutes = 0
    @Published var agreeToRest = 0
    @Published var disagreeToRest = 0
    
    func sessionJoined(_ session: GroupSession<RestTogether>) {
        messenger = GroupSessionMessenger(session: session)
        listenToMessages()
        keepParticipantCount()
        if session.state != .joined { session.join() }
    }
    
    private func keepParticipantCount() {
        guard let session else { return }
        session
            .$activeParticipants
            .sink { self.participantCount = $0.count }
            .store(in: &cancellables)
    }
    
    private func setMinutes(_ minutes: Int) {
        self.minutes = minutes
    }
    
    private func addVoteCount(agree: Int, disagree: Int) {
        agreeToRest += agree
        disagreeToRest += disagree
        print(agreeToRest, disagreeToRest)
    }
    
    private func listenToMessages() {
        guard let messenger else { return }
        Task.detached {
            for await (message, _) in messenger.messages(of: VoteMessage.self) {
                switch message.step {
                case .enterRoom:
                    await self.appendStep(.enterRoom)
                case .wantToRest(let minutes):
                    await self.setMinutes(minutes)
                    await self.appendStep(.wantToRest(minutes: minutes))
                case .voteToRest(let agree, let disagree):
                    await self.addVoteCount(agree: agree, disagree: disagree)
                    await self.appendStep(.voteToRest(argree: agree, disagree: disagree))
                case .readyToRest(let minutes):
                    await self.appendStep(.readyToRest(minutes: minutes))
                case .startToRest(minutes: let minutes):
                    await self.appendStep(.startToRest(minutes: minutes))
                case .failToRest:
                    await self.appendStep(.failToRest)
                case .finishRest:
                    await self.appendStep(.finishRest)
                }
            }
        }
    }
    
    func send(_ message: VoteMessage) async throws {
        switch message.step {
        case .enterRoom:
            break
        case .wantToRest(let minutes):
            break
        case .voteToRest(let argree, let disagree):
            addVoteCount(agree: argree, disagree: disagree)
            print(self.agreeToRest, self.disagreeToRest)
        case .readyToRest(let minutes):
            break
        case .startToRest(let minutes):
            break
        case .failToRest:
            break
        case .finishRest:
            break   
        }
        try await messenger?.send(message)
        appendStep(message.step)
    }
    
    private func reset() {
        agreeToRest = 0
        disagreeToRest = 0
        currentRestTime += minutes
        minutes = 0
    }
}
