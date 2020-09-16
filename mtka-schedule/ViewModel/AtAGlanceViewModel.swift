//
//  AtAGlanceViewModel.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/15/20.
//

import Foundation

protocol AtAGlanceViewModelProtocol: ObservableObject {
    var rightNow: String { get }
    var upNext: String { get }
}

class AtAGlanceViewModel: AtAGlanceViewModelProtocol {
    @Published var rightNow: String = ""
    @Published var upNext: String = ""
}
