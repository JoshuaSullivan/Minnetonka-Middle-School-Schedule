//
//  TimeOfDay.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation

struct TimeOfDay {
    let hours: Int
    let minutes: Int

    var string: String { "\(hours):\( minutes < 10 ? "0\(minutes)" : "\(minutes)")" }
}
