//
//  HolidayService.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/20/20.
//

import Foundation
import Combine

protocol HolidayServiceProtocol {
    var holidays: AnyPublisher<[SimpleDate], Never> { get }
}

final class SchoolCalendarService: HolidayServiceProtocol {
    let _holidays = CurrentValueSubject<[SimpleDate], Never>([])

    var holidays: AnyPublisher<[SimpleDate], Never> {
        _holidays.share().eraseToAnyPublisher()
    }

    
}
