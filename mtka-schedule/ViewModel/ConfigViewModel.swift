//
//  ConfigViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation

protocol ConfigViewModelProtocol: ObservableObject {
    var screenTitle: String { get }
}

class ConfigViewModel: ConfigViewModelProtocol {
    var screenTitle: String { return "Settings" }
}
