//
//  ScheduleService.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/15/20.
//

import Foundation
import Combine

protocol ScheduleServiceProtocol {
    func scheduleForWeek(containing date: Date) -> AnyPublisher<[Schedule], Never>
    func firstDayOfWeek(containing date: Date) -> Date
}

class ScheduleService: ScheduleServiceProtocol {

    struct WeekPublisher {
        let date: Date
        let publisher: CurrentValueSubject<[Schedule], Never>
    }

    static let dateKeyFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .none
        return df
    }()

    let storage: StorageServiceProtocol

    private var schedules: [String: WeekPublisher] = [:]

    var configuration: Configuration = .empty {
        didSet {
            updateSchedules()
        }
    }

    var configSub: AnyCancellable?

    init(storage: StorageServiceProtocol) {
        self.storage = storage
        configSub = storage.configuration.sink { config in
            self.configuration = config
        }
    }

    func scheduleForWeek(containing date: Date) -> AnyPublisher<[Schedule], Never> {
        let keyDate = firstDayOfWeek(containing: date)
        let key = Self.dateKeyFormatter.string(from: keyDate)
        if let week = schedules[key] {
            return week.publisher.share().eraseToAnyPublisher()
        }
        let schedule = generateScheduleForWeek(startingOn: keyDate)
        let publisher = CurrentValueSubject<[Schedule], Never>(schedule)
        schedules[key] = WeekPublisher(date: keyDate, publisher: publisher)
        return publisher.share().eraseToAnyPublisher()
    }

    private func updateSchedules() {
        schedules.values.forEach { week in
            week.publisher.send(generateScheduleForWeek(startingOn: week.date))
        }
    }

    /// - Note: This method expects that `forDate` has already been set to Sunday.
    ///
    private func generateScheduleForWeek(startingOn date: Date) -> [Schedule] {
        // TODO: Verify that this calculation will hold true once we enter the year 2021.
        /// Get the week of the year.
        let weekOfYear = Calendar.current.component(.weekOfYear, from: date)

        /// Even weeks are A, odd are B
        let isWeekA = weekOfYear % 2 == 0

        // Generate Monday through Friday.
        let days: [Schedule] = (1...5).map { offset in
            let dayDate = date.adding(days: offset)
            let components: [ScheduleComponent]
            var isWednesday = false
            if offset == 1 || offset == 4 {
                components = ScheduleTemplate.getTemplate(pattern: .dayOne(segment1: configuration.periods[0].type, gradeLevel: configuration.gradeLevel, segment3: configuration.periods[2].type))
            } else if offset == 2 || offset == 5 {
                components = ScheduleTemplate.getTemplate(pattern: .dayTwo(segment1: configuration.periods[3].type, gradeLevel: configuration.gradeLevel, segment3: configuration.periods[5].type))
            } else {
                isWednesday = true
                components = ScheduleTemplate.getTemplate(pattern: .wednesday)
            }
            let blocks: [Schedule.Block] = components.map { comp in
                switch comp.period {
                case .classtime(let index, let pattern):
                    guard let periodConfig = configuration.periods.first(where: { $0.index == index }) else {
                        preconditionFailure("Encountered unexpected period index: \(index)")
                    }
                    let classConfig: ClassConfiguration
                    switch pattern {
                    case .whole:
                        if isWednesday && periodConfig.type != .whole {
                            classConfig = isWeekA ? periodConfig.firstClass : periodConfig.secondClass
                        } else {
                            classConfig = periodConfig.firstClass
                        }
                    case .splitA:
                        classConfig = periodConfig.firstClass
                    case .splitB:
                        classConfig = periodConfig.secondClass
                    }
                    return Schedule.Block(component: comp, config: classConfig)

                case .advisory:
                    return Schedule.Block(component: comp, advisoryTeacher: configuration.advisoryTeacher)

                case .lunch, .checkAndConnect, .mastOfficeHours:
                    return Schedule.Block(component: comp)
                }
            }
            return Schedule(name: DateFormatter.dayOfWeekFormatter.string(from: dayDate), blocks: blocks)
        }
        return days
    }

    func firstDayOfWeek(containing date: Date) -> Date {
        // Reminder: weekdays are 1-indexed with Sunday as the first day.
        let dayOfWeek = Calendar.current.component(.weekday, from: date)

        // Find the offset of the Monday in the current week.
        var offset = 1 - dayOfWeek

        // We want Saturday to show the next week, not the preceeding one.
        if offset == -6 { offset = 1 }

        // Find the appropriate Monday.
        return date.adding(days: offset)
    }
}
