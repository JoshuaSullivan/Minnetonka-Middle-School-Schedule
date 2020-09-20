//
//  Schedule.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/17/20.
//

import Foundation

struct Schedule {
    struct Block: Identifiable, Comparable {
        var id: String
        var className: String
        var teacher: String?
        var start: TimeOfDay
        var end: TimeOfDay

        var meetCode: String? {
            guard let teacher = teacher else { return nil }
            return teacher.lowercased().components(separatedBy: .whitespaces).joined()
        }

        static func < (lhs: Block, rhs: Block) -> Bool {
            return lhs.start < rhs.start
        }
    }

    let name: String
    let date: SimpleDate
    let blocks: [Block]
    let isShortDay: Bool
    let isConferenceDay: Bool

    init(name: String, date: SimpleDate, blocks: [Block], isShortDay: Bool = false, isConferenceDay: Bool = false) {
        self.name = name
        self.date = date
        self.blocks = blocks
        self.isShortDay = isShortDay
        self.isConferenceDay = isConferenceDay
    }
}

extension Schedule {
    static func noSchool(name: String, date: SimpleDate, isConferenceDay: Bool = false) -> Schedule {
        return Schedule(name: name, date: date, blocks: [.noSchool], isConferenceDay: isConferenceDay)
    }

    static func summerBreak(name: String, date: SimpleDate) -> Schedule {
        return Schedule(name: name, date: date, blocks: [.summerBreak])
    }
}

extension Schedule.Block {
    init(component: ScheduleComponent, config: ClassConfiguration? =  nil, advisoryTeacher: String? = nil) {

        start = component.start
        end = component.end
        id = UUID().uuidString

        switch component.period {
        case .classtime:
            guard let config = config else {
                preconditionFailure("You must provide a class when the type of the ScheduleComponent is .classtime")
            }
            className = config.name
            teacher = config.teacher
        case .lunch:
            className = "Lunch"
        case .advisory:
            className = "Advisory"
            teacher = advisoryTeacher
        case .checkAndConnect:
            className = "CheckAndConnect"
        case .mastOfficeHours:
            className = "MAST / Office Hours"
        }
    }

    static let noSchool = Schedule.Block(
        id: "no-school",
        className: "No School",
        teacher: nil,
        start: TimeOfDay(hours: 9, minutes: 30),
        end: TimeOfDay(hours: 10, minutes: 00)
    )

    static let summerBreak = Schedule.Block(
        id: "summerBreak",
        className: "Summer Break",
        teacher: nil,
        start: TimeOfDay(hours: 9, minutes: 30),
        end: TimeOfDay(hours: 10, minutes: 00)
    )
}
