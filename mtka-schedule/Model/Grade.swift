//
//  Grade.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

enum Grade: String, Hashable, Identifiable, CaseIterable, Codable {
    case six = "6"
    case seven = "7"
    case eight = "8"

    var lunchDuration: Int {
        return self == .eight ? 54 : 53
    }

    var lunchBlockSpacing: Int {
        return self == .eight ? 4 : 5
    }

    var id: String {
        return self.rawValue
    }
}
