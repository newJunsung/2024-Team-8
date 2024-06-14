//
//  NavigationManager.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import Foundation

final class NavigationManager: ObservableObject {
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
}
