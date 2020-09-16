//
//  StorageService.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/14/20.
//

import Foundation
import Combine

protocol StorageServiceProtocol {
    var configuration: AnyPublisher<Configuration, Never> { get }

    func set(configuration: Configuration)
}

final class StorageService: StorageServiceProtocol {

    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()

    private static let defaultsKey = "configurationData"

    var configuration: AnyPublisher<Configuration, Never> {
        return _config
            .share()
            .eraseToAnyPublisher()
    }

    private var _config: CurrentValueSubject<Configuration, Never>

    private var currentConfig: Configuration = .empty {
        didSet {
            _config.send(currentConfig)
        }
    }

    init() {
        // Attempt to load cached configuration data.
        if
            let data = UserDefaults.standard.data(forKey: Self.defaultsKey),
            let storedConfig = try? Self.decoder.decode(Configuration.self, from: data)
        {
            // Success! Use it as our starting value.
            currentConfig = storedConfig
        }
        _config = CurrentValueSubject<Configuration, Never>(currentConfig)
    }

    func set(configuration: Configuration) {
        do {
            let data = try Self.encoder.encode(configuration)
            UserDefaults.standard.set(data, forKey: Self.defaultsKey)
            currentConfig = configuration
        } catch {
            print("ERROR: Failed to save configuration: \(error)")
        }
    }
}
