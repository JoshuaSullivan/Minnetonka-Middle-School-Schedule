//
//  Day.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

struct Day: CustomStringConvertible {
    typealias DateResolver = (Int) -> Date

    let offset: Int
    let blocks: [Block]

    var description: String {
        let blockDescription = blocks
            .map { $0.description}
            .joined(separator: "\n")
        return "Day \(offset)\n\(blockDescription)"
    }

    func description(with date: Date) -> String {
        let offsetDate = date.adding(days: offset)
        let blockDescription = blocks
            .map { $0.description}
            .joined(separator: "\n")
        return "\(DateFormatter.dayOfWeekFormatter.string(from: offsetDate))\n\(blockDescription)"
    }
}
