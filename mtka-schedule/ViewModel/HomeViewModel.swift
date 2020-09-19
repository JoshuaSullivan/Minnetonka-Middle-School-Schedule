//
//  HomeViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var scheduleViewModel: ScheduleViewModel { get }
}

class HomeViewModel: HomeViewModelProtocol {

    private var scheduleService: ScheduleServiceProtocol

    var scheduleViewModel: ScheduleViewModel

    init(scheduleService: ScheduleServiceProtocol) {
        self.scheduleService = scheduleService
        scheduleViewModel = ScheduleViewModel(scheduleService: scheduleService, startDate: Date())
    }
}
