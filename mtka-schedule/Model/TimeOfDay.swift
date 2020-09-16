//
//  TimeOfDay.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

struct TimeOfDay: Equatable, Comparable, CustomStringConvertible {
    let hours: Int
    let minutes: Int

    var description: String {
        var normalizedHours = hours % 12
        if normalizedHours == 0 { normalizedHours = 12 }
        return "\(normalizedHours):\(minutes < 10 ? "0\(minutes)" : "\(minutes)")"
    }

    func duration(to otherTime: TimeOfDay) -> Int {
        return (otherTime.hours * 60 - hours * 60) + (otherTime.minutes - minutes)
    }

    func adding(duration: Int) -> TimeOfDay {
        let totalMinutes = minutes + duration
        return TimeOfDay(hours: hours + (totalMinutes / 60), minutes: totalMinutes % 60)
    }

    func toDate(baseDate date: Date) -> Date? {
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        comps.hour = hours
        comps.minute = minutes
        comps.second = 0
        return Calendar.current.date(from: comps)
    }

    static func < (lhs: TimeOfDay, rhs: TimeOfDay) -> Bool {
        if lhs.hours < rhs.hours {
            return true
        } else if lhs.hours > rhs.hours {
            return false
        }
        return lhs.minutes < rhs.minutes
    }
}
