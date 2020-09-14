//
//  ConfigViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import SwiftUI

protocol ConfigViewModelProtocol: ObservableObject {
    var screenTitle: String { get }
    var studentName: String { get set }
    var gradeLevel: Grade { get set }
    var periods: [PeriodConfiguration] { get set }

    func saveTapped()
}

class ConfigViewModel: ConfigViewModelProtocol {

    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()

    private let defaultsKey = "configurationData"

    var screenTitle: String { return "Settings" }

    var studentName: String = ""

    var gradeLevel: Grade = Grade.six

    var periods: [PeriodConfiguration] = [
        PeriodConfiguration(index: 1),
        PeriodConfiguration(index: 2),
        PeriodConfiguration(index: 3),
        PeriodConfiguration(index: 4),
        PeriodConfiguration(index: 5),
        PeriodConfiguration(index: 6),
    ]

    init() {
        loadConfiguration()
    }

    func saveTapped() {
        saveConfiguration()
    }

    private func saveConfiguration() {
        let config = Configuration(studentName: studentName, gradeLevel: gradeLevel, schedule: periods)
        do {
            let data = try ConfigViewModel.encoder.encode(config)
            UserDefaults.standard.set(data, forKey: defaultsKey)
        } catch {
            print("Failed to save data: \(error)")
        }
    }

    private func loadConfiguration() {
        guard let data = UserDefaults.standard.data(forKey: defaultsKey) else {
            print("No saved data found. Using default values.")
            return
        }
        do {
            let config = try ConfigViewModel.decoder.decode(Configuration.self, from: data)
            studentName = config.studentName
            gradeLevel = config.gradeLevel
            periods = config.schedule
            objectWillChange.send()
        } catch {
            print("Failed to decode data: \(error)")
        }
    }
}
