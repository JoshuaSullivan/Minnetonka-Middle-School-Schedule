//
//  Date.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

extension Date {
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    func atMidnight() -> Date {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: comps)!
    }

    var timeOfDay: TimeOfDay {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: self)
        return TimeOfDay(hours: comps.hour ?? 0, minutes: comps.minute ?? 0)
    }
}
