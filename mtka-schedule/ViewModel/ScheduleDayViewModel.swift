//
//  ScheduleDayViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import Foundation

protocol ScheduleDayViewModelProtocol: ObservableObject {
    var name: String { get }
    var blocks: [ScheduleBlockViewModel] { get }
    var isShortDay: Bool { get }
    var isConferenceDay: Bool { get }
}

final class ScheduleDayViewModel: ScheduleDayViewModelProtocol {
    let name: String
    let date: SimpleDate
    let isShortDay: Bool
    let isConferenceDay: Bool

    let blocks: [ScheduleBlockViewModel]

    init(schedule: Schedule) {
        date = schedule.date
        name = schedule.name
        blocks = schedule.blocks.sorted().map { ScheduleBlockViewModel(block: $0, date: schedule.date) }
        isShortDay = schedule.isShortDay
        isConferenceDay = schedule.isConferenceDay
    }
}

extension ScheduleDayViewModel: Identifiable {
    var id: String { name }
}
