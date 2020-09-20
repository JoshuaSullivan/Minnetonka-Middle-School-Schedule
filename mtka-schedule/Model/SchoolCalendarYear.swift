//
//  SchoolCalendarYear.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/20/20.
//

import Foundation

struct SchoolCalendarYear {
    let firstDay: SimpleDate
    let lastDay: SimpleDate
    let noSchool: [SimpleDate]
    let shortDays: [SimpleDate]
    let conferences: [SimpleDate]

    func contains(date: SimpleDate) -> Bool {
        return date >= firstDay && date <= lastDay
    }
}

extension SchoolCalendarYear: Codable {}

extension SchoolCalendarYear: Equatable {}

extension SchoolCalendarYear: Comparable {
    static func < (lhs: SchoolCalendarYear, rhs: SchoolCalendarYear) -> Bool {
        return lhs.firstDay < rhs.firstDay
    }
}
