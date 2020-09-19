//
//  Configuraton.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/14/20.
//

import Foundation

struct Configuration: Codable {
    let studentName: String
    let gradeLevel: Grade
    let periods: [PeriodConfiguration]
    let advisoryTeacher: String

    static let empty = Configuration(
        studentName: "",
        gradeLevel: .six,
        periods: [
            PeriodConfiguration(index: 1),
            PeriodConfiguration(index: 2),
            PeriodConfiguration(index: 3),
            PeriodConfiguration(index: 4),
            PeriodConfiguration(index: 5),
            PeriodConfiguration(index: 6),
        ],
        advisoryTeacher: ""
    )
}
