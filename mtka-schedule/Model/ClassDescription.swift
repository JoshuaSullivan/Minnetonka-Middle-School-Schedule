//
//  ClassDescription.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation

struct ClassDescription {
    let name: String
    let teacher: String

    var meetCode: String { teacher.lowercased().split(separator: " ").joined(separator: "") }
}
