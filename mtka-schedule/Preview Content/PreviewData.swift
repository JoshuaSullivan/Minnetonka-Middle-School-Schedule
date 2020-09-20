//
//  PreviewData.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import Foundation

enum PreviewData {
    enum ScheduleMocks {
        static let schedule = Schedule(
            name: "Tuesday, 9/21",
            blocks: [
                Schedule.Block(component: ScheduleComponent(period: .lunch, start: TimeOfDay(hours: 11, minutes: 30), end: TimeOfDay(hours: 12, minutes: 10))),
            ]
        )
    }
}
