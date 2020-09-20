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
    let blocks: [Block]
}

extension Schedule.Block {
    init(component: ScheduleComponent, config: ClassConfiguration? =  nil, advisoryTeacher: String? = nil) {

        start = component.start
        end = component.end
        let id = UUID().uuidString

        switch component.period {
        case .classtime:
            guard let aClass = config?.asClass else {
                preconditionFailure("You must provide a class when the type of the ScheduleComponent is .classtime")
            }
            self.id = aClass.id
            className = aClass.name
            teacher = aClass.teacher
        case .lunch:
            self.id = id
            className = "Lunch"
        case .advisory:
            self.id = id
            className = "Advisory"
            teacher = advisoryTeacher
        case .checkAndConnect:
            self.id = id
            className = "CheckAndConnect"
        case .mastOfficeHours:
            self.id = id
            className = "MAST / Office Hours"
        }
    }
}
