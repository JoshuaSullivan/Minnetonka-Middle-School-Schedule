//
//  Date.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

extension Date {
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}
