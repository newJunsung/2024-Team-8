//
//  RestTogether.swift
//  Team8
//
//  Created by 김준성 on 6/15/24.
//

import GroupActivities

struct RestTogether: GroupActivity {
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = "함께 쉬어요!"
        metadata.type = .generic
        return metadata
    }
}
