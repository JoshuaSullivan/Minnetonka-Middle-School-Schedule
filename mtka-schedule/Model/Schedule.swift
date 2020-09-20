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
}
