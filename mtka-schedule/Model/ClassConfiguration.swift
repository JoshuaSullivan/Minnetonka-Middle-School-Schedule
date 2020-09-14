//
//  ClassConfiguration.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

class ClassConfiguration: ObservableObject, Codable {
    
    var name: String
    var teacher: String

    init(aClass: Class) {
        self.name = aClass.name
        self.teacher = aClass.teacher
    }

    init(name: String = "", teacher: String = "") {
        self.name = name
        self.teacher = teacher
    }

    var asClass: Class { Class(name: name, teacher: teacher) }
}

extension ClassConfiguration: CustomStringConvertible {
    var description: String {
        return "\(name) - \(teacher)"
    }
}
