//
//  PeriodConfiguration.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import SwiftUI

class PeriodConfiguration: Identifiable, ObservableObject, Codable {

    enum PeriodType: Int, Hashable, Identifiable, CaseIterable, Codable {
        case whole
        case split

        var id: Int { rawValue }

        var pickerName: String {
            switch self {
            case .whole: return "Whole"
            case .split: return "Split"
            }
        }
    }

    let index: Int
    var type: PeriodType {
        didSet {
            self.objectWillChange.send()
        }
    }
    var firstClass: ClassConfiguration
    var secondClass: ClassConfiguration

    init(index: Int, type: PeriodType = .whole, firstClass: ClassConfiguration = ClassConfiguration(), secondClass: ClassConfiguration = ClassConfiguration()) {
        self.index = index
        self.type = type
        self.firstClass = firstClass
        self.secondClass = secondClass
    }

    var id: Int {
        return index
    }
}

extension PeriodConfiguration: CustomStringConvertible {
    var description: String {
        var output = "Period \(index)"
        if type == .whole {
            output += "\n\t\(firstClass.description)"
        } else {
            output += "\n\t\(firstClass.description)"
            output += "\n\t\(secondClass.description)"
        }
        return output
    }
}
