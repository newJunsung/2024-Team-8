//
//  VoteMessage.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import Foundation

struct VoteMessage: Codable, Identifiable, Hashable {
    let id: UUID
    let step: VoteStep
}

enum VoteStep: Hashable, Codable {
    case enterRoom
    case wantToRest(minutes: Int)
    case voteToRest(argree: Int, disagree: Int)
    case readyToRest(minutes: Int)
    case startToRest(minutes: Int)
    case failToRest
    case finishRest
}
