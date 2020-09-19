//
//  DateFormatter.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation

extension DateFormatter {

    /// A date formatter which returns the full weekday name for the provided date.
    ///
    static let weekdayNameFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df
    }()

    static let dayOfWeekFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: "EMd", options: 0, locale: Locale.autoupdatingCurrent)
        return df
    }()

    static let dateMonthFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: "Md", options: 0, locale: Locale.autoupdatingCurrent)
        return df
    }()
}
