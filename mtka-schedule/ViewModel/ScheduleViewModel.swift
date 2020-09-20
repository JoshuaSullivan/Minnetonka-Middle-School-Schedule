//
//  ScheduleViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/17/20.
//

import Foundation
import Combine

protocol ScheduleViewModelProtocol: ObservableObject {
    var weekName: String { get }
    var days: [ScheduleDayViewModel] { get }

    func prevWeekTapped()
    func nextWeekTapped()
}

class ScheduleViewModel: ScheduleViewModelProtocol {

    @Published var weekName: String = ""
    @Published var days: [ScheduleDayViewModel] = []

    private var scheduleService: ScheduleServiceProtocol
    private var scheduleSub: AnyCancellable?

    var anchorDate: Date

    init(scheduleService: ScheduleServiceProtocol, startDate: Date = Date()) {
        self.scheduleService = scheduleService
        anchorDate = startDate

        switchToWeek(containing: startDate)
    }

    func switchToWeek(containing date: Date) {
        scheduleSub = scheduleService.scheduleForWeek(containing: date).sink(receiveValue: {[weak self] scheduleDays in
            self?.days = scheduleDays.map { ScheduleDayViewModel(schedule: $0) }
        })
        let monday = scheduleService.firstDayOfWeek(containing: date).adding(days: 1)
        weekName = DateFormatter.dateMonthFormatter.string(from: monday)
    }

    func prevWeekTapped() {
        anchorDate = anchorDate.adding(days: -7)
        switchToWeek(containing: anchorDate)
    }

    func nextWeekTapped() {
        anchorDate = anchorDate.adding(days: 7)
        switchToWeek(containing: anchorDate)
    }
}
