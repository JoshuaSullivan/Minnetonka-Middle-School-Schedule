//
//  PeriodConfigViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation

protocol PeriodConfigViewModelProtocol: ObservableObject {
    
}

class PeriodConfigViewModel: PeriodConfigViewModelProtocol {
    var period: Int
    var className: String
    var teacherName: String
    var gradeLevel: GradeLevel

    init(period: Int, className: String, teacherName: String, gradeLevel: GradeLevel) {
        self.period = period
        self.className = className
        self.teacherName = teacherName
        self.gradeLevel = gradeLevel
    }
}
