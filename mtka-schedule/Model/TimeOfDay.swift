//
//  TimeOfDay.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

struct TimeOfDay: CustomStringConvertible {
    let hours: Int
    let minutes: Int

    var description: String {
        let normalizedHours = hours > 12 ? hours - 12 : hours
        return "\(normalizedHours):\(minutes < 10 ? "0\(minutes)" : "\(minutes)")"
    }

    func duration(to otherTime: TimeOfDay) -> Int {
        return (otherTime.hours * 60 - hours * 60) + (otherTime.minutes - minutes)
    }

    func adding(duration: Int) -> TimeOfDay {
        let totalMinutes = minutes + duration
        return TimeOfDay(hours: hours + (totalMinutes / 60), minutes: totalMinutes % 60)
    }
}
