//
//  SchoolCalendarService.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/20/20.
//

import Foundation
import Combine

protocol SchoolCalendarServiceProtocol {
    func getProperies(forDate date: SimpleDate) -> SchoolDayProperties
}

final class SchoolCalendarService: SchoolCalendarServiceProtocol {

    static let shared = SchoolCalendarService()

    private let decoder = JSONDecoder()

    private let years: [SchoolCalendarYear]

    private init() {
        guard
            let url = Bundle.main.url(forResource: "calendar-data", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let years = try? decoder.decode([SchoolCalendarYear].self, from: data)
        else {
            preconditionFailure("Unable to load calendar data from the bundle.")
        }
        self.years = years
    }

    func getProperies(forDate date: SimpleDate) -> SchoolDayProperties {
        guard let year = years.first(where:{ $0.contains(date: date) }) else {
            return .summerBreak
        }
        let isConference = year.conferences.contains(date)
        if year.noSchool.contains(date) {
            return SchoolDayProperties(type: .noSchool, isConferenceDay: isConference)
        } else if year.shortDays.contains(date) {
            return SchoolDayProperties(type: .shortDay, isConferenceDay: isConference)
        }
        return SchoolDayProperties(type: .regular, isConferenceDay: isConference)
    }
}
