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
}

final class ScheduleDayViewModel: ScheduleDayViewModelProtocol {
    let date: SimpleDate
    let name: String
    let blocks: [ScheduleBlockViewModel]

    init(schedule: Schedule, date: SimpleDate) {
        self.date = date
        name = schedule.name
        blocks = schedule.blocks.sorted().map { ScheduleBlockViewModel(block: $0, date: date) }
    }
}

extension ScheduleDayViewModel: Identifiable {
    var id: String { name }
}
