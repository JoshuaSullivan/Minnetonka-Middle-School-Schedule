//
//  ScheduleBlockViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import Foundation
import Combine

protocol ScheduleBlockViewModelProtocol: ObservableObject {
    var timespan: String { get }
    var title: String { get }
    var meetCode: String? { get }
    var duration: Int { get }
    var markerTime: Int? { get }
}

final class ScheduleBlockViewModel: ScheduleBlockViewModelProtocol {
    var timespan: String { "\(block.start.description) - \(block.end.description)" }

    var title: String {
        if let teacher = block.teacher {
            return "\(block.className) - \(teacher)"
        }
        return block.className
    }

    var meetCode: String? { block.meetCode }

    var duration: Int { block.start.duration(to: block.end) }

    @Published var markerTime: Int?

    private let block: Schedule.Block

    private var tickerSub: AnyCancellable?

    init(block: Schedule.Block, ticker: MinuteTicker = MinuteTicker.shared) {
        self.block = block

        let time = Date().timeOfDay
        if time >= block.start && time < block.end {
            self.markerTime = block.start.duration(to: time)
        }

        tickerSub = ticker.ticker.sink(receiveValue: {[weak self] time in
            if time >= block.start && time < block.end {
                self?.markerTime = block.start.duration(to: time)
            } else {
                self?.markerTime = nil
            }
        })
    }
}

extension ScheduleBlockViewModel: Identifiable {
    var id: String { title }
}
