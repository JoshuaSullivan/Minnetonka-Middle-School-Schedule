//
//  Week.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

struct Week: CustomStringConvertible {
    let start: Date
    let days: [Day]

    var description: String {
        return days
            .map { $0.description(with: start) }
            .joined(separator: "\n\n")
    }
}
