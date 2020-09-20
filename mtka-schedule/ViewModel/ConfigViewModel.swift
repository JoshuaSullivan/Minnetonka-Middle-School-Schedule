//
//  ConfigViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation
import Combine

protocol ConfigViewModelProtocol: ObservableObject {
    var screenTitle: String { get }
    var studentName: String { get set }
    var gradeLevel: Grade { get set }
    var advisoryTeacher: String { get set }
    var periods: [PeriodConfiguration] { get set }

    func saveTapped()
}

class ConfigViewModel: ConfigViewModelProtocol {

    private let storageService: StorageServiceProtocol

    private var storageSub: AnyCancellable?

    var screenTitle: String { return "Settings" }

    @Published var studentName: String = ""

    @Published var gradeLevel: Grade = Grade.six

    @Published var advisoryTeacher: String = ""

    @Published var periods: [PeriodConfiguration] = [
        PeriodConfiguration(index: 1),
        PeriodConfiguration(index: 2),
        PeriodConfiguration(index: 3),
        PeriodConfiguration(index: 4),
        PeriodConfiguration(index: 5),
        PeriodConfiguration(index: 6),
    ]

    init(storage: StorageServiceProtocol) {
        self.storageService = storage

        storageSub = storage.configuration.sink { [weak self] config in
            guard let self = self else { return }
            self.studentName = config.studentName
            self.gradeLevel = config.gradeLevel
            self.periods = config.periods
        }
    }

    func saveTapped() {
        let config = Configuration(studentName: studentName, gradeLevel: gradeLevel, periods: periods, advisoryTeacher: advisoryTeacher)
        storageService.set(configuration: config)
    }
}
