//
//  HomeViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: ObservableObject {
    var screenTitle: String { get }

    var configViewModel: ConfigViewModel { get }

    var atAGlanceViewModel: AtAGlanceViewModel { get }
}

class HomeViewModel: HomeViewModelProtocol {

    private var storageService: StorageServiceProtocol

    private var tickSub: AnyCancellable?

    @Published var screenTitle: String = ""

    @Published var configViewModel: ConfigViewModel

    @Published var atAGlanceViewModel: AtAGlanceViewModel = AtAGlanceViewModel()

    init(storage: StorageServiceProtocol) {
        self.storageService = storage

        configViewModel = ConfigViewModel(storage: storageService)

        tickSub = MinuteTicker.shared.ticker.sink(receiveValue: handleTimeChange)
    }

    private func handleTimeChange(time: TimeOfDay) {
        screenTitle = "\(DateFormatter.weekdayNameFormatter.string(from: Date())) - \(time)"
    }
}
