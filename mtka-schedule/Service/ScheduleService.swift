//
//  ScheduleService.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/15/20.
//

import Foundation
import Combine

protocol ScheduleServiceProtocol {
//    func schedule(for date: Date) -> AnyPublisher<Block, Never>
}

class ScheduleService: ScheduleServiceProtocol {

    let storage: StorageServiceProtocol

    init(storage: StorageServiceProtocol) {
        self.storage = storage
    }
}
