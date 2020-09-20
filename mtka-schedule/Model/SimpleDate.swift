//
//  SimpleDate.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/20/20.
//

import Foundation

struct SimpleDate: Equatable, Comparable {
    let year: Int
    let month: Int
    let day: Int

    static func < (lhs: SimpleDate, rhs: SimpleDate) -> Bool {
        if lhs.year < rhs.year {
            return true
        } else if lhs.year > rhs.year {
            return false
        }
        if lhs.month < rhs.month {
            return true
        } else if lhs.month > rhs.month {
            return false
        }
        return lhs.day < rhs.day
    }

    var isToday: Bool {
        return Date().simpleDate == self
    }

    var date: Date {
        let comps = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: comps) ?? Date()
    }
}

extension SimpleDate: Codable {
    enum CodingKeys: String, CodingKey {
        case year = "y"
        case month = "m"
        case day = "d"
    }
}
