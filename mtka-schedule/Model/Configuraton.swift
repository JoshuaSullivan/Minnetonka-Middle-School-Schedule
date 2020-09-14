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
    let schedule: [PeriodConfiguration]
}
