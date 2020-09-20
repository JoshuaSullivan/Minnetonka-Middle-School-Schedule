//
//  SchoolDayProperties.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/20/20.
//

import Foundation

struct SchoolDayProperties {
    enum DayType {
        case regular
        case shortDay
        case noSchool
        case summerBreak
    }

    let type: DayType
    let isConferenceDay: Bool
}

extension SchoolDayProperties {
    static let summerBreak = SchoolDayProperties(type: .summerBreak, isConferenceDay: false)
}
