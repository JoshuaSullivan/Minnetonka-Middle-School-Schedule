//
//  ScheduleTemplate.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/17/20.
//

import Foundation

struct ScheduleComponent {
    enum PeriodType {

        enum ClassPattern {
            case whole
            case splitA
            case splitB
        }

        case classtime(Int, ClassPattern)
        case lunch
        case advisory
        case checkAndConnect
        case mastOfficeHours
    }

    let period: PeriodType
    let start: TimeOfDay
    let end: TimeOfDay
}

enum ScheduleTemplate {

    enum Pattern {
        case dayOne(segment1: PeriodConfiguration.PeriodType, gradeLevel: Grade, segment3: PeriodConfiguration.PeriodType)
        case dayTwo(segment1: PeriodConfiguration.PeriodType, gradeLevel: Grade, segment3: PeriodConfiguration.PeriodType)
        case wednesday
    }

    static func getTemplate(pattern: Pattern) -> [ScheduleComponent] {
        var comps = [checkAndConnect]

        switch pattern {

        case .wednesday:
            return Wednesday.wednesday

        case .dayOne(let segment1, let gradeLevel, let segment3):
            comps.append(contentsOf: segment1 == .whole ? DayOne.Segment1.whole : DayOne.Segment1.split)
            switch gradeLevel {
            case .six: comps.append(contentsOf: DayOne.Segment2.gradeSix)
            case .seven: comps.append(contentsOf: DayOne.Segment2.gradeSeven)
            case .eight: comps.append(contentsOf: DayOne.Segment2.gradeEight)
            }
            comps.append(contentsOf: segment3 == .whole ? DayOne.Segment3.whole : DayOne.Segment3.split)

        case .dayTwo(let segment1, let gradeLevel, let segment3):
            comps.append(contentsOf: segment1 == .whole ? DayTwo.Segment1.whole : DayTwo.Segment1.split)
            switch gradeLevel {
            case .six: comps.append(contentsOf: DayTwo.Segment2.gradeSix)
            case .seven: comps.append(contentsOf: DayTwo.Segment2.gradeSeven)
            case .eight: comps.append(contentsOf: DayTwo.Segment2.gradeEight)
            }
            comps.append(contentsOf: segment3 == .whole ? DayTwo.Segment3.whole : DayTwo.Segment3.split)
        }
        return comps
    }

    static let checkAndConnect = ScheduleComponent(
        period: .checkAndConnect,
        start: TimeOfDay(hours: 9, minutes: 15),
        end: TimeOfDay(hours: 9, minutes: 30)
    )

    enum DayOne {

        enum Segment1 {

            static let whole = [
                ScheduleComponent(
                    period: .classtime(1, .whole),
                    start: TimeOfDay(hours: 9, minutes: 30),
                    end: TimeOfDay(hours: 11, minutes: 06)
                )
            ]

            static let split = [
                ScheduleComponent(
                    period: .classtime(1, .splitA),
                    start: TimeOfDay(hours: 9, minutes: 30),
                    end: TimeOfDay(hours: 10, minutes: 17)
                ),
                ScheduleComponent(
                    period: .classtime(1, .splitB),
                    start: TimeOfDay(hours: 10, minutes: 21),
                    end: TimeOfDay(hours: 11, minutes: 06)
                )
            ]
        }

        enum Segment2 {
            static let gradeSix = [
                ScheduleComponent(
                    period: .lunch,
                    start: TimeOfDay(hours: 11, minutes: 12),
                    end: TimeOfDay(hours: 12, minutes: 05)
                ),
                ScheduleComponent(
                    period: .classtime(2, .whole),
                    start: TimeOfDay(hours: 12, minutes: 10),
                    end: TimeOfDay(hours: 13, minutes: 58)
                )
            ]

            static let gradeSeven = [
                ScheduleComponent(
                    period: .classtime(2, .whole),
                    start: TimeOfDay(hours: 11, minutes: 12),
                    end: TimeOfDay(hours: 13, minutes: 00)
                ),
                ScheduleComponent(
                    period: .lunch,
                    start: TimeOfDay(hours: 13, minutes: 05),
                    end: TimeOfDay(hours: 13, minutes: 58)
                )
            ]

            static let gradeEight = [
                ScheduleComponent(
                    period: .classtime(2, .splitA),
                    start: TimeOfDay(hours: 11, minutes: 12),
                    end: TimeOfDay(hours: 12, minutes: 04)
                ),
                ScheduleComponent(
                    period: .lunch,
                    start: TimeOfDay(hours: 12, minutes: 08),
                    end: TimeOfDay(hours: 13, minutes: 02)
                ),
                ScheduleComponent(
                    period: .classtime(2, .splitB),
                    start: TimeOfDay(hours: 13, minutes: 06),
                    end: TimeOfDay(hours: 13, minutes: 58)
                )
            ]
        }

        enum Segment3 {
            static let whole = [
                ScheduleComponent(
                    period: .classtime(3, .whole),
                    start: TimeOfDay(hours: 14, minutes: 03),
                    end: TimeOfDay(hours: 15, minutes: 40)
                )
            ]

            static let split = [
                ScheduleComponent(
                    period: .classtime(3, .splitA),
                    start: TimeOfDay(hours: 14, minutes: 03),
                    end: TimeOfDay(hours: 14, minutes: 50)
                ),
                ScheduleComponent(
                    period: .classtime(3, .splitB),
                    start: TimeOfDay(hours: 14, minutes: 53),
                    end: TimeOfDay(hours: 15, minutes: 40)
                )
            ]
        }
    }

    enum DayTwo {

        enum Segment1 {

            static let whole = [
                ScheduleComponent(
                    period: .classtime(4, .whole),
                    start: TimeOfDay(hours: 9, minutes: 30),
                    end: TimeOfDay(hours: 11, minutes: 06)
                )
            ]

            static let split = [
                ScheduleComponent(
                    period: .classtime(4, .splitA),
                    start: TimeOfDay(hours: 9, minutes: 30),
                    end: TimeOfDay(hours: 10, minutes: 17)
                ),
                ScheduleComponent(
                    period: .classtime(4, .splitB),
                    start: TimeOfDay(hours: 10, minutes: 21),
                    end: TimeOfDay(hours: 11, minutes: 06)
                )
            ]
        }

        enum Segment2 {
            static let gradeSix = [
                ScheduleComponent(
                    period: .lunch,
                    start: TimeOfDay(hours: 11, minutes: 12),
                    end: TimeOfDay(hours: 12, minutes: 05)
                ),
                ScheduleComponent(
                    period: .classtime(5, .whole),
                    start: TimeOfDay(hours: 12, minutes: 10),
                    end: TimeOfDay(hours: 13, minutes: 58)
                )
            ]

            static let gradeSeven = [
                ScheduleComponent(
                    period: .classtime(5, .whole),
                    start: TimeOfDay(hours: 11, minutes: 12),
                    end: TimeOfDay(hours: 13, minutes: 00)
                ),
                ScheduleComponent(
                    period: .lunch,
                    start: TimeOfDay(hours: 13, minutes: 05),
                    end: TimeOfDay(hours: 13, minutes: 58)
                )
            ]

            static let gradeEight = [
                ScheduleComponent(
                    period: .classtime(5, .splitA),
                    start: TimeOfDay(hours: 11, minutes: 12),
                    end: TimeOfDay(hours: 12, minutes: 04)
                ),
                ScheduleComponent(
                    period: .lunch,
                    start: TimeOfDay(hours: 12, minutes: 08),
                    end: TimeOfDay(hours: 13, minutes: 02)
                ),
                ScheduleComponent(
                    period: .classtime(5, .splitB),
                    start: TimeOfDay(hours: 13, minutes: 06),
                    end: TimeOfDay(hours: 13, minutes: 58)
                )
            ]
        }

        enum Segment3 {
            static let whole = [
                ScheduleComponent(
                    period: .classtime(6, .whole),
                    start: TimeOfDay(hours: 14, minutes: 03),
                    end: TimeOfDay(hours: 15, minutes: 40)
                )
            ]

            static let split = [
                ScheduleComponent(
                    period: .classtime(6, .splitA),
                    start: TimeOfDay(hours: 14, minutes: 03),
                    end: TimeOfDay(hours: 14, minutes: 50)
                ),
                ScheduleComponent(
                    period: .classtime(6, .splitB),
                    start: TimeOfDay(hours: 14, minutes: 53),
                    end: TimeOfDay(hours: 15, minutes: 40)
                )
            ]
        }
    }

    enum Wednesday {
        static let wednesday = [
            ScheduleComponent(
                period: .classtime(1, .whole),
                start: TimeOfDay(hours: 9, minutes: 15),
                end: TimeOfDay(hours: 9, minutes: 45)
            ),
            ScheduleComponent(
                period: .classtime(2, .whole),
                start: TimeOfDay(hours: 9, minutes: 50),
                end: TimeOfDay(hours: 10, minutes: 20)
            ),
            ScheduleComponent(
                period: .classtime(3, .whole),
                start: TimeOfDay(hours: 10, minutes: 25),
                end: TimeOfDay(hours: 10, minutes: 55)
            ),
            ScheduleComponent(
                period: .classtime(4, .whole),
                start: TimeOfDay(hours: 11, minutes: 00),
                end: TimeOfDay(hours: 11, minutes: 30)
            ),
            ScheduleComponent(
                period: .advisory,
                start: TimeOfDay(hours: 11, minutes: 30),
                end: TimeOfDay(hours: 12, minutes: 00)
            ),
            ScheduleComponent(
                period: .lunch,
                start: TimeOfDay(hours: 12, minutes: 00),
                end: TimeOfDay(hours: 12, minutes: 45)
            ),
            ScheduleComponent(
                period: .classtime(5, .whole),
                start: TimeOfDay(hours: 12, minutes: 45),
                end: TimeOfDay(hours: 13, minutes: 15)
            ),
            ScheduleComponent(
                period: .classtime(6, .whole),
                start: TimeOfDay(hours: 13, minutes: 20),
                end: TimeOfDay(hours: 13, minutes: 50)
            ),
            ScheduleComponent(
                period: .mastOfficeHours,
                start: TimeOfDay(hours: 14, minutes: 00),
                end: TimeOfDay(hours: 15, minutes: 55)
            ),
        ]
    }
}
