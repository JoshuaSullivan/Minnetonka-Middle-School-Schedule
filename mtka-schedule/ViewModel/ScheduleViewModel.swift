//
//  ScheduleViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/17/20.
//

import Foundation

protocol ScheduleViewModelProtocol: ObservableObject {
    var weekName: String { get }
    var days: [Schedule] { get }
}

class ScheduleViewModel: ScheduleViewModelProtocol {

    @Published var weekName: String = ""
    @Published var days: [Schedule] = []

    private var scheduleService: ScheduleServiceProtocol

    var anchorDate: Date

    init(scheduleService: ScheduleServiceProtocol, startDate: Date = Date()) {
        self.scheduleService = scheduleService
        anchorDate = startDate
    }
}
