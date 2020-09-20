//
//  HomeViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var title: String { get }
    var scheduleViewModel: ScheduleViewModel { get }
}

class HomeViewModel: HomeViewModelProtocol {

    private var scheduleService: ScheduleServiceProtocol

    @Published var title: String = ""

    var scheduleViewModel: ScheduleViewModel

    var tickSub: AnyCancellable?

    init(scheduleService: ScheduleServiceProtocol, ticker: MinuteTicker = MinuteTicker.shared) {
        self.scheduleService = scheduleService
        scheduleViewModel = ScheduleViewModel(scheduleService: scheduleService, startDate: Date())
        tickSub = ticker.ticker.sink(receiveValue: { [weak self] time in
            self?.setTitle(withDate: Date(), andTime: time)
        })
        let now = Date()
        setTitle(withDate: now, andTime: now.timeOfDay)
    }

    private func setTitle(withDate date: Date, andTime time: TimeOfDay) {
        let dateString = DateFormatter.dayOfWeekFormatter.string(from: date)
        let timeString = time.description
        let title = "\(dateString) - \(timeString)"
        if title != self.title {
            self.title = title
        }
    }
}
