//
//  HomeViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var screenTitle: String { get }

    var configViewModel: ConfigViewModel { get }
}

class HomeViewModel: HomeViewModelProtocol {
    var screenTitle: String {
        DateFormatter.weekdayNameFormatter.string(from: Date())
    }

    var configViewModel: ConfigViewModel {
        return ConfigViewModel()
    }
}
